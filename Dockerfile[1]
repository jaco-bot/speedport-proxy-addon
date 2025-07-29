FROM python:3.11-alpine
RUN pip install flask requests
WORKDIR /app
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh
CMD ["/app/run.sh"]
