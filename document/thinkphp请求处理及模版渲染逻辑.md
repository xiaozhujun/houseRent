index.php -> require './ThinkPHP/ThinkPHP.php'
Think.php -> require THINK_PATH.'Common/runtime.php'
runtime.php -> Think::Start()
Think.class.php -> Start() ->  App::run()
App.class.php -> run() -> App::init() -> App::exec() -> call_user_func(array(&$module,'_before_'.$action))
ModuleAction -> method()

以BaeAction.class.php->index()为例

$this->display()
Action.class.php -> $this->view->display($templateFile,$charset,$contentType)
View.class.php -> display() -> tag('view_begin',$templateFile)
common.php -> tag() -> B($name, $params) -> $behavior->run($params)
LocationTemplateBehavior.class.php -> run() -> parseTemplateFile($templateFile) -> $templateFile = C('TEMPLATE_NAME')

当没有指定模版时默认为 ./houseRent/Tpl/Bae/index.tpl 过程见 
App.class.php ->  init() 
	/* 模板相关目录常量 */
        define('THEME_NAME',   $templateSet);                  // 当前模板主题名称
        $group   =  defined('GROUP_NAME')?GROUP_NAME.'/':'';
        define('THEME_PATH',   TMPL_PATH.$group.(THEME_NAME?THEME_NAME.'/':''));
        define('APP_TMPL_PATH',__ROOT__.'/'.APP_NAME.(APP_NAME?'/':'').basename(TMPL_PATH).'/'.$group.(THEME_NAME?THEME_NAME.'/':''));
        C('TEMPLATE_NAME',THEME_PATH.MODULE_NAME.(defined('GROUP_NAME')?C('TMPL_FILE_DEPR'):'/').ACTION_NAME.C('TMPL_TEMPLATE_SUFFIX'));
        C('CACHE_PATH',CACHE_PATH.$group);