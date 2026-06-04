FROM alpine:latest AS builder
RUN apk add --no-cache g++ cmake make
WORKDIR /app
COPY main.cpp .
RUN g++ -std=c++11 -pthread main.cpp -o quadrat-service

FROM alpine:latest
RUN apk add --no-cache libstdc++
WORKDIR /app
COPY --from=builder /app/quadrat-service .
EXPOSE 8080
CMD ["./quadrat-service"]
