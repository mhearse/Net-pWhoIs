# Net-pWhoIs
Perl library for the The Prefix WhoIs Project (pWhoIs).  [On CPAN](https://metacpan.org/pod/Net::pWhoIs)

RECENT: Added bulk query suport, reusing a single socket.

The prefix whois service expects IP address queries.  This library makes an efforce to resolve hostnames if needed.

Example of what this library returns.
<pre>
SINGLE (returns Hash)
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

BULK (returns Hash of Hashes)
$VAR1 = {
          '166.70.12.30' => {
                              'cache-date' => '1501915575',
                              'as-path' => '8492 6939 6315',
                              'prefix' => '166.70.0.0/16',
                              'country' => 'United States',
                              'latitude' => '41.735490',
                              'net-name' => 'XMISSION-166-70-0-0',
                              'org-name' => 'XMission, L.C.',
                              'origin-as' => '6315',
                              'as-org-name' => 'XMission, L.C.',
                              'country-code' => 'US',
                              'region' => 'Utah',
                              'longitude' => '-111.834390',
                              'city' => 'Logan',
                              'ip' => '166.70.12.30'
                            },
          '67.225.131.208' => {
                                'region' => 'Michigan',
                                'longitude' => '-84.637765',
                                'city' => 'Lansing',
                                'ip' => '67.225.131.208',
                                'as-org-name' => 'Liquid Web, L.L.C',
                                'country-code' => 'US',
                                'org-name' => 'Liquid Web, L.L.C',
                                'origin-as' => '32244',
                                'latitude' => '42.733280',
                                'net-name' => 'LIQUIDWEB',
                                'prefix' => '67.225.128.0/17',
                                'country' => 'United States',
                                'cache-date' => '1501915575',
                                'as-path' => '8492 9002 3356 32244'
                              },
          'perlmonks.org' => {
                               'region' => 'Pennsylvania',
                               'city' => 'Pittsburgh',
                               'ip' => '216.92.34.251',
                               'longitude' => '-79.980960',
                               'as-org-name' => 'pair Networks',
                               'country-code' => 'US',
                               'org-name' => 'pair Networks',
                               'origin-as' => '7859',
                               'net-name' => 'PAIRNET-BLK-3',
                               'latitude' => '40.424880',
                               'prefix' => '216.92.0.0/16',
                               'country' => 'United States',
                               'as-path' => '3561 209 7859',
                               'cache-date' => '1501915575'
                             },
        };
</pre>
