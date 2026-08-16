#!/usr/bin/env python3

import argparse
import json
import os
import tempfile
import urllib.error
import urllib.request
from pathlib import Path
from typing import Any


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Add models exposed by an OpenAI-compatible endpoint to OpenCode."
    )
    parser.add_argument(
        "--config",
        type=Path,
        default=Path(__file__).with_name("opencode.json"),
    )
    parser.add_argument("--provider", default="aktiv")
    parser.add_argument("--dry-run", action="store_true")
    return parser.parse_args()


def load_json(path: Path) -> dict[str, Any]:
    with path.open(encoding="utf-8") as file:
        value = json.load(file)
    if not isinstance(value, dict):
        raise ValueError(f"{path} must contain a JSON object")
    return value


def get_provider(config: dict[str, Any], provider_id: str) -> dict[str, Any]:
    providers = config.get("provider")
    if not isinstance(providers, dict):
        raise ValueError("OpenCode config does not contain a provider object")
    provider = providers.get(provider_id)
    if not isinstance(provider, dict):
        raise ValueError(f"OpenCode config does not contain provider {provider_id!r}")
    return provider


def fetch_models(provider: dict[str, Any]) -> list[dict[str, Any]]:
    options = provider.get("options")
    if not isinstance(options, dict):
        raise ValueError("Provider does not contain an options object")
    base_url = options.get("baseURL")
    if not isinstance(base_url, str) or not base_url:
        raise ValueError("Provider options do not contain baseURL")
    api_key = os.environ.get("AKTIV_API_KEY") or options.get("apiKey")
    headers = {"Accept": "application/json"}
    if isinstance(api_key, str) and api_key:
        headers["Authorization"] = f"Bearer {api_key}"
    request = urllib.request.Request(f"{base_url.rstrip('/')}/models", headers=headers)
    try:
        with urllib.request.urlopen(request, timeout=30) as response:
            payload = json.load(response)
    except urllib.error.HTTPError as error:
        raise RuntimeError(f"Model endpoint returned HTTP {error.code}") from error
    except urllib.error.URLError as error:
        raise RuntimeError(f"Could not reach model endpoint: {error.reason}") from error
    if not isinstance(payload, dict) or not isinstance(payload.get("data"), list):
        raise ValueError("Model endpoint response does not contain a data array")
    models = []
    for item in payload["data"]:
        if isinstance(item, dict) and isinstance(item.get("id"), str) and item["id"]:
            models.append(item)
    if not models:
        raise ValueError("Model endpoint returned no model IDs")
    return models


def add_models(provider: dict[str, Any], remote_models: list[dict[str, Any]]) -> list[str]:
    models = provider.setdefault("models", {})
    if not isinstance(models, dict):
        raise ValueError("Provider models must be an object")
    added = []
    for remote_model in sorted(remote_models, key=lambda item: item["id"].casefold()):
        model_id = remote_model["id"]
        if model_id in models:
            continue
        display_name = remote_model.get("name")
        models[model_id] = {
            "name": display_name if isinstance(display_name, str) and display_name else model_id
        }
        added.append(model_id)
    return added


def write_json(path: Path, config: dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    descriptor, temporary_name = tempfile.mkstemp(
        dir=path.parent,
        prefix=f".{path.name}.",
        suffix=".tmp",
        text=True,
    )
    try:
        with os.fdopen(descriptor, "w", encoding="utf-8") as file:
            json.dump(config, file, indent=2, ensure_ascii=False)
            file.write("\n")
        os.chmod(temporary_name, path.stat().st_mode)
        os.replace(temporary_name, path)
    except BaseException:
        try:
            os.unlink(temporary_name)
        except FileNotFoundError:
            pass
        raise


def main() -> int:
    args = parse_args()
    config = load_json(args.config)
    provider = get_provider(config, args.provider)
    added = add_models(provider, fetch_models(provider))
    if args.dry_run:
        print(f"Would add {len(added)} model(s)")
    elif added:
        write_json(args.config, config)
        print(f"Added {len(added)} model(s) to {args.config}")
    else:
        print("No new models found")
    for model_id in added:
        print(model_id)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
