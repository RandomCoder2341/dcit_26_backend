FROM ubuntu:22.04

# 1. Install compiler AND the missing tools (curl, zip, unzip, tar)
RUN apt-get update && apt-get install -y build-essential cmake git curl zip unzip tar

# 2. Install vcpkg
RUN git clone https://github.com/microsoft/vcpkg.git /vcpkg
RUN /vcpkg/bootstrap-vcpkg.sh -disableMetrics

# 3. Install the C++ libraries (This might take 5-10 minutes on Render)
RUN /vcpkg/vcpkg install crow nlohmann-json

# 4. Set up our app
WORKDIR /app
COPY server.cpp .

# 5. Compile the C++ code for Linux
RUN g++ server.cpp -I /vcpkg/installed/x64-linux/include -L /vcpkg/installed/x64-linux/lib -lcrow -lpthread -o server

# 6. Run the server
EXPOSE 8080
CMD ["./server"]