docker run --rm -v ./../:/app -w /app  -it instrumentisto/flutter:3.19.4 /bin/bash -c "flutter build web && rm -rf .dart_tool"
