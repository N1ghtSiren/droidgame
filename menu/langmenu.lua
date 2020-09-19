menu_lang = {}

function menu_lang.create(groupID)
    local obj = object.create(groupID)
    
    function obj.ondraw()
        local height = love.graphics.getHeight()
        local width = love.graphics.getWidth()
        local printf = love.graphics.printf
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(font_main)

        textwidth = font_main:getWidth("... ??? !!!")
        printf("... ??? !!!", width/2-textwidth/2, height*0.05, 999)

        textwidth = font_main:getWidth("English")
        printf("English", width/2-textwidth/2, height*0.3, 999)

        textwidth = font_main:getWidth("日本語")
        printf("日本語", width/2-textwidth/2, height*0.45, 999)

    end

    function obj.onupdate(dt)

        local textheight = font_main:getHeight()

        local width = love.graphics.getWidth()
        local height = love.graphics.getHeight()
        --
        local textwidth = font_main:getWidth("English")
        local minx = width/2-textwidth/2
        if(touches.isInArea(minx-textwidth/2, height*0.3, minx+textwidth, height*0.3+textheight))then
            settings.language = "_en"
            swapLanguage()

            obj.perform(false)
            MainMenu.perform(true)
            touches.pause(1)
            settings.firstLaunch = 0
            checkSettings()
            saveSettings()
        end
        --
        textwidth = font_main:getWidth("日本語")
        minx = width/2-textwidth/2
        if(touches.isInArea(minx, height*0.45, minx+textwidth, height*0.45+textheight))then
            settings.language = "_jp"
            swapLanguage()

            obj.perform(false)
            MainMenu.perform(true)
            touches.pause(1)
            settings.firstLaunch = 0
            checkSettings()
            saveSettings()
        end
        --
        touches.clear()
    end

    function obj.oncreate()
        
    end

    function obj.ondestroy()

    end
    
    return obj
end

function swapLanguage()
    if(settings.language=="_en")then
        font_big = love.graphics.newFont("libs/comicsans.ttf", font_size_big)
        font_main = love.graphics.newFont("libs/comicsans.ttf", font_size_main)
    elseif(settings.language=="_jp")then
        font_big = love.graphics.newFont("libs/umeboshi.ttf", font_size_big)
        font_main = love.graphics.newFont("libs/umeboshi.ttf", font_size_main)
    end
end

function getLocalizedString(engString)
    if(settings.language=="_en")then
        return engString
    end

    if(settings.language=="_jp")then
        setupCase(engString)
        return case("Bubbles","バブル")or 
               case("Start Game","ゲームをスタート")or
               case("Options","セッティング")or
               case("Exit","エグジット")or

               case("Back","バック")or

               case("Short game - 200 taps","ショートゲーム-200タップ")or
               case("Medium game - 500 taps","中程度のゲーム-500タップ")or
               case("Long game - 1000 taps","ロングゲーム-1000タップ")or

               case("Circle Max Size","サークル最大サイズ")or
               case("Field Size: ","フィールドサイズ ")or
               case("Music Volume","音楽の音量")or
               case("Pop sound","ポップ音")or
               case("Language","言語")or
               case("Reset to Default","デフォルトにリセット")or

               case("yes","はい")or
               case("no","番号")or

               case("Score: ","スコア ")or
               case("Taps: ","タップ ")or

               case("PAUSE","休止")or
               case("Best: ","ベスト ")or
               case("NEW RECORD!","新記録!")or
               case("Max Combo: ","最大コンボ ")or    
               case("Taps Left: ","左タップ ")or
               case("To Main Menu","メインメニューへ")or
               case("Continue","継続する")or

               case("GAME OVER","ゲームオーバー")or
               case("Tap Limit: ","タップ制限 ")or
               case("Play Again","再びプレー")or

               case("combo: ","コンボ ")or

               "error"
    end

end