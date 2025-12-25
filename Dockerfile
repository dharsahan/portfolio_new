# Stage 1: Build the Flutter web app
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Copy pubspec files first to leverage cache
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the app
COPY . .

# Build for web
RUN flutter build web

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the build artifacts from the build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
