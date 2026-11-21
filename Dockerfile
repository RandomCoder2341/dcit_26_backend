FROM ubuntu:22.04

# Install compiler, JSON library, ASIO (Crow's dependency), and OpenSSL
RUN apt-get update && apt-get install -y build-essential git libasio-dev nlohmann-json3-dev libssl-dev

# Download the Crow source code (It's header-only, so we just need the files)
RUN git clone https://github.com/CrowCpp/Crow.git /Crow

# Set up our app
WORKDIR /app
COPY server.cpp .

# Compile the C++ code using the downloaded Crow headers and Ubuntu's system libraries
RUN g++ server.cpp -I /Crow/include -I /usr/include -L /usr/lib -lpthread -o server

# Run the server
EXPOSE 8080
CMD ["./server"]