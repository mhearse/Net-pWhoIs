# Net-pWhoIs
Perl library for pWhoIs

The prefix whois service expects IP address queries.  This library makes an efforce to resolve hostnames if needed.

Example of what this library returns.
$VAR1 = {
          'ip' => '193.62.192.4',
          'as-path' => '852 1299 786',
          'country' => 'United Kingdom',
          'longitude' => '0.242340',
          'region' => 'England',
          'latitude' => '52.023370',
          'net-name' => 'EUR-BIO-INST',
          'org-name' => 'European Bioinformatics Institute',
          'cache-date' => '1501738056',
          'prefix' => '193.60.0.0/14',
          'as-org-name' => 'Jisc Services Limited',
          'city' => 'Saffron Walden',
          'origin-as' => '786',
          'country-code' => 'GB'
        };
