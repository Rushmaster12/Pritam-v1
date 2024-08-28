FROM node:lts-buster

# Set the Node.js environment to production
ENV NODE_ENV=production

# Install necessary packages and clean up to reduce image size
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    software-properties-common \
    ffmpeg \
    imagemagick \
    webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available) for better caching
COPY package*.json ./

# Install dependencies and globally required packages
RUN npm install && npm install -g qrcode-terminal pm2

# Copy the rest of the application files
COPY . .

# Start the application using npm
CMD ["npm", "start"]