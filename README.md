# rpa-rpa
OO flows managing an OO/RPA instance and its components (Central, Insights, Designer, SSX and IDM)

Once you deploy this CP, configure properties in **io.cloudslang.microfocus.oo** property file (central_url, designer_url, ssx_url, idm_url, insights_url, etc.).

For Designer and IDM related flows, you may specify the user credentials. If not specified and/or for all the other flows (Central, Insights, SSX), the only user used is the one specified in **io.cloudslang.microfocus.oo.oo_username / oo_password** properties.
