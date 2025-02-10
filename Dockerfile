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

FROM python:3.12.8 AS final_stage
RUN mkdir /app
WORKDIR /app

COPY --from=python_stage /app/execution_time.txt /app/python_execution_time.txt
COPY --from=javascript_stage /app/execution_time.txt /app/javascript_execution_time.txt
COPY --from=java_stage /app/execution_time.txt /app/java_execution_time.txt
COPY --from=cpp_stage /app/execution_time.txt /app/cpp_execution_time.txt
COPY --from=rust_stage /app/execution_time.txt /app/rust_execution_time.txt

COPY write_table.py /app
RUN pip install --no-cache-dir tabulate

CMD ["python", "write_table.py"]