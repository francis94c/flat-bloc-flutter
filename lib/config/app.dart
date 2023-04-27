// ignore_for_file: constant_identifier_names

const bool DEBUG = true;
const bool BRIDGE_HOST = true;

const String NGROK_ID = "d860-102-67-1-124";

const String BASE_URL = DEBUG
    ? (BRIDGE_HOST
        ? 'http://10.0.2.2:3000/v1/'
        : 'https://$NGROK_ID.eu.ngrok.io/v1/')
    : 'https://dev.some-service.com/v1/';

final Map<String, dynamic> baseHeaders = {'Accept': 'application/json'};
