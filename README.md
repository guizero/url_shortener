# URL SHORTENER

This is URL shortener is part of of a Specialized Evaluation on RoR for **Bluecoding**.

## Installation

For standardization and keeping unison development environment this project uses **Docker**.

Pre-requisites:

-   Docker
-   Docker-compose

Clone the repository and run:

```bash
$ docker-compose build
$ docker-compose run --rm website bundle install
$ docker-compose run --rm website bundle exec rails db:create db:migrate
$ docker-compose up
```

Then, visit: http://localhost:3000
A demo version can be visited on: [http://ashorturl.herokuapp.com](http://ashorturl.herokuapp.com/)

## Short Code Logic

The short code logic was based on the discussion on the following Stack Overflow thread:
(https://stackoverflow.com/questions/742013/how-do-i-create-a-url-shortener)
which leads to this repository:
[https://github.com/delight-im/ShortURL](https://github.com/delight-im/ShortURL)

The logic is quite simple. A given integer (id) iterates over a base 49 "alphabet" to determine its string counterpart. The logic is then reversed to "decode" the given string.

This allows the shortest possible length for the code one char for integers from 1 to 48. For this project I have also decided to:

-   Remove some characters form the alphabet to avoid ambiguous codes ('I', 'l', '1', 'O' and '0');
-   Remove all vowels to avoid creating phrases that could be offensive;

Nonetheless my first option would be to use the [HashIds](https://github.com/peterhellberg/hashids.rb) gem for it offers many benefits over the above-mentioned solution. I have decided not to use it because the shortest string it returns is composed by two characeters - thus not the shortest possible code.

## License

[MIT](https://choosealicense.com/licenses/mit/)
