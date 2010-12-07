CONFIG_DIR = "#{File.dirname(__FILE__)}/xml"
REPOSITORY_BASE_DIR = "/Users/monster/Development/repos/Current/"

CEA_CONFIG = "#{CONFIG_DIR}/cea_dumped_config.xml"
ASSETS_CONFIG = "#{CONFIG_DIR}/assets_dumped_config.xml"
CEA_WEB_CONTENT = "com.clickfox.app.cea/WebContent"
CEA_FLEX_BASE = "com.clickfox.flex.app.cea/src/main/flex"
ASSETS_BASE = "com.clickfox.flex.library.assets"

CEA_INPUT  = "#{REPOSITORY_BASE_DIR}/#{CEA_FLEX_BASE}/cfportal.mxml"
CEA_OUTPUT = "#{REPOSITORY_BASE_DIR}/#{CEA_WEB_CONTENT}/cfportal.swf"
CEA_SPIKE_IN = "#{REPOSITORY_BASE_DIR}/#{CEA_FLEX_BASE}/spike.mxml"
CEA_SPIKE_OUT = "#{REPOSITORY_BASE_DIR}/#{CEA_WEB_CONTENT}/spike.swf"
ASSETS_INPUT  = "#{REPOSITORY_BASE_DIR}/#{ASSETS_BASE}/src"
ASSETS_BIN  = "#{REPOSITORY_BASE_DIR}/#{ASSETS_BASE}/bin"
ASSETS_OUTPUT = "#{REPOSITORY_BASE_DIR}/#{CEA_WEB_CONTENT}/assets.swc"

CEA_TEST_ARGS = "-o=#{REPOSITORY_BASE_DIR}/#{CEA_WEB_CONTENT}/TestRunner.swf -library-path+=#{REPOSITORY_BASE_DIR}/#{ASSETS_BASE}/bin/#{ASSETS_BASE}.swc  -library-path+=#{REPOSITORY_BASE_DIR}/com.clickfox.flex.library.common/lib -library-path+=#{REPOSITORY_BASE_DIR}/com.clickfox.flex.app.cea/src/test/flex/lib -sp+=#{REPOSITORY_BASE_DIR}/com.clickfox.flex.library.common/src/locale/ -sp+=#{REPOSITORY_BASE_DIR}/com.clickfox.flex.library.common/src/ -sp+=#{REPOSITORY_BASE_DIR}/#{CEA_FLEX_BASE}/ -sp+=#{REPOSITORY_BASE_DIR}/com.clickfox.flex.app.cea/src/test/flex/ -locale=en_US -keep-as3-metadata+=Test,Transient,NonCommittingChangeEvent,ChangeEvent,Managed,Bindable -debug=true -file-specs=#{REPOSITORY_BASE_DIR}/#{CEA_FLEX_BASE}/TestRunner.mxml"