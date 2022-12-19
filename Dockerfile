FROM node:19.2-alpine AS build-client
WORKDIR /client
COPY ./client/package.json .
RUN npm install
COPY ./client/. .
RUN npm run build

FROM golang:1.19 AS build-server
WORKDIR /server
COPY ./server/go.mod .
COPY ./server/go.sum .
COPY ./server/pb_migrations ./pb_migrations
COPY ./server/*.go .
RUN CGO_ENABLED=0 go build -o app.o

FROM alpine:latest
WORKDIR /app
COPY --from=build-client /client/build pb_public
COPY --from=build-server /server/pb_migrations pb_migrations
COPY --from=build-server /server/app.o app.o

EXPOSE 8090

ENTRYPOINT [ "/app/app.o", "serve", "--http=0.0.0.0:8090" ]