FROM ubuntu:22.04

# Install C++ compiler and tools
RUN apt-get update && apt-get install -y build-essential cmake git

# Install vcpkg and libraries
RUN git clone https://github.com/microsoft/vcpkg.git /vcpkg && \
    /vcpkg/bootstrap-vcpkg.sh && \
    /vcpkg/vcpkg install crow nlohmann-json

# Set up our app
WORKDIR /app
COPY server.cpp .

# Compile the C++ code for Linux
RUN g++ server.cpp -I /vcpkg/installed/x64-linux/include -L /vcpkg/installed/x64-linux/lib -lcrow -lpthread -o server

# Run the server
EXPOSE 8080
CMD ["./server"]