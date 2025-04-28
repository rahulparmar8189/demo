FROM node:20

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies with security audit
RUN npm install && npm audit fix

# Copy source code
COPY . .

# Expose the port
EXPOSE 3000

# Start the application
CMD ["npm", "start"] 