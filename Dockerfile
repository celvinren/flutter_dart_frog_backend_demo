# Official Dart image: https://hub.docker.com/_/dart
# Specify the Dart SDK base image version using dart:<version> (ex: dart:2.17)
FROM dart:stable AS build

WORKDIR /app

# Copy app source code and AOT compile it.
COPY . .

# Install Dependencies

# Copy app source code and AOT compile it.
COPY backend/build ./build

# Ensure packages are still up-to-date if anything has changed
RUN dart pub get -C build
RUN mkdir bin
RUN dart compile exe build/bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/


# Start server.
CMD ["/app/bin/server"]