$:.unshift(File.dirname(__FILE__))
require 'local_constants'

CONFIG_DIR              = "#{File.dirname(__FILE__)}/xml/local_build_config"

CEA_FLEX_BASE           = "com.clickfox.flex.app.cea/src/main/flex"                        
CEA_WEB_CONTENT         = "com.clickfox.app.cea/WebContent"
CEA_BIN                 = "#{REPOSITORY_BASE_DIR}/#{CEA_WEB_CONTENT}"
CEA_INPUT               = "#{REPOSITORY_BASE_DIR}/#{CEA_FLEX_BASE}/cfportal.mxml"
CEA_OUTPUT              = "#{CEA_BIN}/cfportal.swf"
CEA_CONFIG              = "#{CONFIG_DIR}/cea_dumped_config.xml"

CEA_SPIKE_IN            = "#{REPOSITORY_BASE_DIR}/#{CEA_FLEX_BASE}/spike.mxml"
CEA_SPIKE_OUT           = "#{REPOSITORY_BASE_DIR}/#{CEA_WEB_CONTENT}/spike.swf"

MANAGEMENT_FLEX_BASE    = "com.clickfox.flex.app.management/src"
MANAGEMENT_WEB_CONTENT  = "com.clickfox.app.management/WebContent"
MANAGEMENT_INPUT        = "#{REPOSITORY_BASE_DIR}/#{MANAGEMENT_FLEX_BASE}/management.mxml"
MANAGEMENT_BIN          = "#{REPOSITORY_BASE_DIR}/#{MANAGEMENT_WEB_CONTENT}"
MANAGEMENT_OUTPUT       = "#{MANAGEMENT_BIN}/management.swf"
MANAGEMENT_CONFIG       = "#{CONFIG_DIR}/management_dumped_config.xml"

LOGIN_FLEX_BASE         = "com.clickfox.flex.module.login/src"
LOGIN_WEB_CONTENT       = "com.clickfox.app.management/WebContent"
LOGIN_BIN               = "#{REPOSITORY_BASE_DIR}/#{LOGIN_FLEX_BASE}/../bin"
LOGIN_INPUT             = "#{REPOSITORY_BASE_DIR}/#{LOGIN_FLEX_BASE}/LoginModule.mxml"
LOGIN_OUTPUT            = "#{LOGIN_BIN}/LoginModule.swf"
LOGIN_CONFIG            = "#{CONFIG_DIR}/login_module_dumped_config.xml"

ASSETS_CONFIG           = "#{CONFIG_DIR}/assets_dumped_config.xml"
ASSETS_BASE             = "com.clickfox.flex.library.assets"
ASSETS_LONG_NAME_SWC    = "com.clickfox.flex.library.assets.swc"

ASSETS_INPUT            = "#{REPOSITORY_BASE_DIR}/#{ASSETS_BASE}/src"
ASSETS_BIN              = "#{REPOSITORY_BASE_DIR}/#{ASSETS_BASE}/bin"
ASSETS_OUTPUT           = "#{ASSETS_BIN}/#{ASSETS_LONG_NAME_SWC}"
                        
CEA_TEST_ARGS           = "-o=#{REPOSITORY_BASE_DIR}/#{CEA_WEB_CONTENT}/TestRunner.swf -library-path+=#{REPOSITORY_BASE_DIR}/#{ASSETS_BASE}/bin/#{ASSETS_BASE}.swc  -library-path+=#{REPOSITORY_BASE_DIR}/com.clickfox.flex.library.common/lib -library-path+=#{REPOSITORY_BASE_DIR}/com.clickfox.flex.app.cea/src/test/flex/lib -sp+=#{REPOSITORY_BASE_DIR}/com.clickfox.flex.library.common/src/locale/ -sp+=#{REPOSITORY_BASE_DIR}/com.clickfox.flex.library.common/src/ -sp+=#{REPOSITORY_BASE_DIR}/#{CEA_FLEX_BASE}/ -sp+=#{REPOSITORY_BASE_DIR}/com.clickfox.flex.app.cea/src/test/flex/ -locale=en_US -keep-as3-metadata+=Test,Transient,NonCommittingChangeEvent,ChangeEvent,Managed,Bindable -debug=true -file-specs=#{REPOSITORY_BASE_DIR}/#{CEA_FLEX_BASE}/TestRunner.mxml"