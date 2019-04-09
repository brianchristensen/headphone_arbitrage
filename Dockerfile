##### stage 1: distillery build #####
FROM bitwalker/alpine-elixir-phoenix:latest AS build

WORKDIR /build
COPY . .

ENV MIX_ENV=prod
ENV ESADDR=http://localhost:9200

RUN cd dashboard && \
    mix clean --deps && \
    mix deps.get --only-prod && \
    mix compile && \
    cd assets  && \
    npm install  && \
    npm run deploy  && \
    cd .. && \
    mix release.init && \
    mix release && \
    mkdir /package && \
    cd /package && \
    cp /build/dashboard/_build/prod/rel/dashboard/releases/0.1.0/dashboard.tar.gz /package/dashboard.tar.gz && \
    tar xvf dashboard.tar.gz && \
    rm dashboard.tar.gz

##### stage 2: run app #####
# the OS here must match the OS from the build stage
FROM alpine:3.9
RUN apk update && apk add --no-cache bash openssl
ENV LANG C.UTF-8

# default host, port and elasticsearch address
ENV MIX_ENV=prod
ENV HOST=localhost
ENV PORT=80
ENV ESADDR=http://localhost:9200

# copy build artifacts
WORKDIR /app
COPY --from=build /package /app

# run 
CMD ["/app/bin/dashboard", "foreground"]
