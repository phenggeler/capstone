ruleset twilio-keys {
  meta {
    name "Twillio keys"
    description <<
These are the keys for testing. This file should not be on a publicly available URL
    >>
    key twilio {
       "account_sid" : "AC4680b0f06cc436900f6216ca67912c1a",
       "auth_token" : "99e91c09bae22353871f020ec30a36b3"
    }     
     
    provide keys twilio to wovyn_base, twilio_v2
  }
}
