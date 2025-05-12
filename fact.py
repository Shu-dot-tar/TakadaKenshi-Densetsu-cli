#!/usr/bin/env python
import requests
import sys
import re

API_URL = "https://api.chucknorris.io/jokes/random"

def get_chuck_norris_fact(name=None):
    """Fetches a random Chuck Norris fact from the API and optionally replaces Chuck Norris with the given name."""
    try:
        response = requests.get(API_URL)
        response.raise_for_status()  #Raise an HTTPError for bad responses (4xx or 5xx)
        data = response.json()
        fact = data.get("value")  #Use .get() for safer dictionary access
        
        #Replace "Chuck Norris" with the provided name if it exists
        if name and fact:
            pattern = re.compile(r'Chuck Norris', re.IGNORECASE)
            fact = pattern.sub(name, fact)
        
        return fact

    except requests.exceptions.RequestException as e:
        print(f"Error fetching fact: {e}", file=sys.stderr)
        return None
    except Exception as e:  #Catch any other potential errors
        print(f"An unexpected error occurred: {e}", file=sys.stderr)
        return None

if __name__ == "__main__":
    #Get the name from command line arguments
    name = sys.argv[1] if len(sys.argv) > 1 else None
    
    fact = get_chuck_norris_fact(name)
    if fact:
        print(fact)
    else:
        sys.exit(1)  #Exit with a non-zero status code to indicate failure