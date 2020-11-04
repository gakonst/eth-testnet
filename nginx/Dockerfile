# https://github.com/MagRelo/docker-eth-demo/tree/master/nginx/dev

# Use the standard Nginx image from Docker Hub
FROM nginx:alpine

# Copy config
COPY ./nginx.conf /etc/nginx/nginx.conf

# Start Nginx when the container has provisioned.
CMD ["nginx", "-g", "daemon off;"]
