<?php

namespace PeanutTest\scripts;

use PeanutTest\scripts\TestScript;
use Tops\sys\TTracer;
use Tops\sys\TWebSite;
class WebsiteTest extends TestScript
{

    public function execute()
    {
        $results = [];
        $results['Domain'] = TWebSite::GetDomain();
        $results['SiteUrl'] = TWebSite::GetSiteUrl();
        $results['ClientIp'] = TWebSite::GetClientIp();
        $results['ExpandedPath'] = TWebSite::ExpandUrl('path');
        $results['CmsType'] = TWebSite::GetCmsType();
        $results['BaseUrl'] = TWebSite::GetBaseUrl();
        $results['IsTestEnv'] = TWebSite::IsTestEnvironment() ? 'Yes' : 'No';

        print_r($results);

        // TTracer::Print('Results:',$results);


    }
}