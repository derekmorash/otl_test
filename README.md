# README

1. (only needed on initial install)

    Create a new dev app in the partners dashboard if you don't already have one.

2. (only needed on initial install)

    Copy .env-start to .env and update `SHOPIFY_API_KEY=` and `SHOPIFY_API_SECRET_KEY=` with the keys for your app in the partners dashboard. .env is git ignored since it contains private keys that are unique to each devs environment, once yours is configured you can forget about it.

3. (only needed on initial install)

    Start by building the containers with `docker-compose build`. The first time doing this it will take a few minutes to download the images, but once they are downloaded it will be quicker the next time. You should also only have to run this command once, if everything builds correctly you can skip this step from now on.

4. In a new terminal tab, use [ngrok](https://ngrok.com/) to forward localhost:3000. ngrok will display a list of information, look for the forwarding url with ssl, something like "https://1234.ngrok.io".

    - run `ngrok http 3000`
    - copy forwarding url, something like "https://1234.ngrok.io"
    - add the forwarding url to your .env file as the APP_BASE_URL
    - go into your apps setup in the partners dashboard and add the forwarding url to the App URL and Whitelisted redirection URL(s) fields.

5. Now that the containers are built, and the app knows what its url is, start the container by running `docker-compose up` in the first terminal tab where the containers were built. The docker containers should be running in one tab and ngrok in the other. Running `docker-compose ps` in another tab should list four containers with a state of "Up"; postgres, redis, sidekiq, and web.

6. (only needed on initial install)

    Run rails db:migrate in the web container to build the database by running `docker-compose exec web rails db:migrate`. You only have to do this the first time setting up your containers. The postgres volume set up in docker-compose.yml will store your local version of the database so when you come back it'll still be there even after containers have been stopped.

7. Open the forwarded ngrok url in a browser to get to the shopify app install page. Paste your store domain in the form and hit install.

8. To stop the containers `Ctrl + c` in the terminal where docker-compose up is running. This should gracefully stop all four containers. If they don't stop, check by running `docker-compose ps`, then run `docker-compose stop`.
