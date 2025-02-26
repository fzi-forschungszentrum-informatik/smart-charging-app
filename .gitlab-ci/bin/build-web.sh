#!/bin/sh -e
flutter build web \
    --release \
    --web-renderer=canvaskit \
    --dart-define=FLUTTER_WEB_CANVASKIT_URL=/canvaskit/

# for nginx gzip_static
gzip --force --keep \
    build/web/main.dart.js \
    build/web/canvaskit/canvaskit.wasm \
    build/web/canvaskit/canvaskit.js
