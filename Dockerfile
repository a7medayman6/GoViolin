# The base image to build the application on top of
FROM golang:1.11-alpine AS compileStage

# create a new directory for the build 
RUN mkdir /build

# change the working directory to /build to get the code and build it
WORKDIR /build

# copy the source code into the container
COPY . .

# Set env variables for go
# OS
ENV GOOS=linux
# GO Module
ENV GO111MODULE=on

ENV CGO_ENABLED=0

# initialize go
RUN go mod init

# Build the go application
RUN go build -o goviolin-main.o .

# make a new directory for the binary to live in
RUN mkdir /app

# change the working directory to /app
WORKDIR /app

# copy the binary to /app directory
RUN cp /build/goviolin-main.o .

# ______________________________________

# new stage to minimize the size
FROM scratch

# Copy the binary file into the new image
COPY --from=compileStage /app/goviolin-main.o /

# Copy the nessecery files
COPY ./ /

# Expose the port the application will run on
EXPOSE 8080

# Run the binary file
ENTRYPOINT [ "./goviolin-main.o" ]