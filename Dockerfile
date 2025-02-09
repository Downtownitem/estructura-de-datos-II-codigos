FROM python:3.12.8 AS python_stage
RUN mkdir /app
WORKDIR /app
COPY python/main.py /app
RUN pip install --no-cache-dir sympy
RUN python main.py

FROM node:18 AS javascript_stage
RUN mkdir /app
WORKDIR /app
COPY javascript/main.js /app
RUN node main.js

FROM amazoncorretto:21 AS java_stage
RUN mkdir /app
WORKDIR /app
COPY java/ExecutionTimeLogger.java /app
RUN javac ExecutionTimeLogger.java
RUN java ExecutionTimeLogger

FROM gcc:12 AS cpp_stage
WORKDIR /app
COPY c++/main.cpp .
RUN g++ main.cpp -o main && ./main

FROM rust:1.72 AS rust_stage
WORKDIR /app
COPY rust/main.rs .
RUN rustc main.rs -o main && ./main

FROM alpine:latest AS final_stage
WORKDIR /app
COPY --from=python_stage /app/execution_time.txt python_execution_time.txt
COPY --from=javascript_stage /app/execution_time.txt javascript_execution_time.txt
COPY --from=java_stage /app/execution_time.txt java_execution_time.txt
COPY --from=cpp_stage /app/execution_time.txt cpp_execution_time.txt
COPY --from=rust_stage /app/execution_time.txt rust_execution_time.txt

CMD cat python_execution_time.txt javascript_execution_time.txt java_execution_time.txt cpp_execution_time.txt rust_execution_time.txt
