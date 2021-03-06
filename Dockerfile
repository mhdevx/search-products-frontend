# stage1 as builder
FROM node:10-alpine as builder

WORKDIR /search-product

# Copy the package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the files
COPY . .

# Build the project
RUN npm run build


FROM nginx:alpine as production-build
COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf

## Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy from the stahg 1
COPY --from=builder /search-product/dist /usr/share/nginx/html

#EXPOSE 80
#ENTRYPOINT ["nginx", "-g", "daemon off;"]
CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/nginx.conf && \
      nginx -g 'daemon off;'