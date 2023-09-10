FROM golang:1.21.1-bookworm AS core_base


FROM core_base AS build


WORKDIR /go/src/test-distroless

COPY . .

RUN ls
RUN go build -o bin/test-distroless ./cmd/server


FROM gcr.io/distroless/static-debian12:nonroot AS production

ENV TZ=Asia/Tokyo

COPY --from=build /go/src/test-distroless/bin /
WORKDIR /

CMD ["./test-distroless"]
