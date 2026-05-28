# Using Fetch API for services

The jQuery ajax library is no longer used for service calls and has been replaced with the Fetch API for better 
performance and flexibility and to eliminate jQuery dependencies.  The Peanut services API remains the same, although
the implementation has been updated to use the Fetch API.

Any future dependecies on jQuery are discouraged.

Files changed: 

- web.root/tq-peanut/pnut/core/Services.ts
- web.root/tq-peanut/pnut/core/Peanut.d.ts
- web.root/tq-peanut/application/config/peanut-bootstrap.php

Error handling fixes:
- web.root/tq-peanut/src/tops/services/ServiceFactory.php
- web.root/tq-peanut/src/tops/services/ServiceRequestHandler.php

 