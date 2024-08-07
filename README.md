# Sweater Weather

## Setup

### Installation

1. Clone the repository:

    ```bash
    git clone git@github.com:RodrigoACG/Sweater_weather.git
    cd Sweater_weather
    ```

2. Install dependencies:

    ```bash
    bundle install
    ```

3. Set up the database:

    ```bash
    rails db:{drop,create,migrate}
    ```

### API Keys

This application requires API keys from MapQuest and WeatherAPI to fetch weather and route data. Follow the instructions below to obtain the API keys:

1. **MapQuest API Key:**

    - Visit the [MapQuest Developer Portal](https://www.mapquestapi.com) and sign up for an account.
    - Once logged in, navigate to the "Keys & Reporting" section and create a new API key.

2. **WeatherAPI Key:**

    - Visit the [WeatherAPI](http://api.weatherapi.com) website and sign up for an account.
    - After signing in, navigate to the API section and generate a new API key.

After obtaining the API keys, add them to your application's environment variables.

## Usage

1. Start the server:

    ```bash
    rails server
    ```

2. Access the API endpoints via `http://localhost:3000`.

## Endpoints

### 1. Retrieve Weather for a City

**Endpoint:**

`GET /api/v1/weather?location=<location>`

If the location is a country, the weather will be returned for the capital of the country.

**Request:**

```http
GET /api/v0/weather?location=Denver, Co
Content-Type: application/json
Accept: application/json
```

**Response:**
```
{
  "data": {
    "id": null,
    "type": "weather",
    "attributes": {
      "current_weather": {
        "last_updated": "2024-08-07 00:45",
        "temperature": 76.1,
        "feels_like": 79.8,
        "humidity": 82,
        "uvi": 1.0,
        "visibility": 6.0,
        "condition": "Partly Cloudy",
        "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
      },
      "daily_weather": [
        {
          "date": "2024-08-07",
          "sunrise": "05:46 AM",
          "sunset": "06:19 PM",
          "max_temp": 83.8,
          "min_temp": 75.0,
          "condition": "Moderate rain",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/302.png"
        }
      ],
      "hourly_weather": [
        {
          "time": "00:00",
          "temperature": 76.3,
          "condition": "Patchy rain nearby",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/176.png"
        }
      ]
    }
  }
}
```


### 2. User Registration
**Endpoint:**

`POST /api/v0/users`

  This endpoint allows a new user to register an account.

**Request:**
```
{
  "email": "example@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

**Response:**

```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "example@example.com",
      "api_key": "generated_api_key"
    }
  }
}
```
### 3. Login
**Endpoint:**

`POST /api/v0/sessions`

This endpoint allows an existing user to log in

**Request:**

```
{
  "email": "example@example.com",
  "password": "password"
}
```
**Response:**
```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "example@example.com",
      "api_key": "generated_api_key"
    }
  }
}
```

### 4. Road Trip Planning
**Endpoint:**

`POST /api/v0/road_trip`

This endpoint allows a user to plan a road trip by providing weather information at the destination.


**Request:**
```
{
  "origin": "Cincinnati, OH",
  "destination": "Denver, CO",
  "api_key": "user_api_key"
}
```

**Response:** 
```{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Cincinnati, OH",
      "end_city": "Denver, CO",
      "travel_time": "18:30:00",
      "weather_at_eta": {
        "datetime": "2024-04-07 23:00",
        "temperature": 44.2,
        "condition": "Cloudy with a chance of rain"
      }
    }
  }
}
```

**Testing:** 

This project includes automated tests to ensure functionality and reliability of the API. To run the tests, execute the following command:

```
 bundle exec rspec
```