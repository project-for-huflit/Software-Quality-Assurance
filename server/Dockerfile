###################
# BUILD FOR LOCAL DEVELOPMENT
###################

FROM node:22-alpine As development

WORKDIR /usr/src/app

COPY package.json .

COPY yarn.lock .

RUN yarn --forzen-lockfile

COPY . .

USER node

###################
# BUILD FOR STAGING
###################

###################
# BUILD FOR PRODUCTION
###################

FROM node:22-alpine As build

WORKDIR /usr/src/app

COPY package.json .

COPY yarn.lock .

COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules

COPY . .

RUN yarn run build
RUN yarn run build:firebase

ENV NODE_ENV production

# Ensures that only the production dependencies are installed. 
# This ensures that the node_modules directory is as optimized as possible
RUN yarn install --production=true --frozen-lockfile && yarn cache clean

USER node

###################
# PRODUCTION
###################

FROM node:22-alpine As production

# Copy the bundled code from the build stage to the production image
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist

# Start the server using the production build
CMD [ "node", "dist/main.js" ]