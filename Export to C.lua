-- Create a new sprite flattened
local name = app.activeSprite.filename:match("^.+/([^.]+).+$")

local sprite = Sprite(app.activeSprite)
app.activeSprite = sprite;

for i,layer in ipairs(sprite.layers) do
  if(layer.isVisible == false) then
    sprite:deleteLayer(layer)
  end
end

sprite:flatten();

-- Define the sprite properties
local image = app.activeImage
local w = sprite.width
local h = sprite.height
local frame_count = #(sprite.frames);

local dlg = Dialog()

dlg:label{ label="Size", text=w.."x"..h }
dlg:label{ label="Frame Count", text=frame_count }
dlg:file{ id="File",
          label="Filename",
          title="Export to C",
          open=false,
          save=true,
          filename=name..".h",
          filetypes={ "h"}}

dlg:button{ text="Close",
  onclick=function()
    dlg:close()
  end }

dlg:button{ text="Export",
  onclick=function()
    -- Exporting sections
    local header =  "#include <stdint.h>\n"..
                    "#include <avr/pgmspace.h>\n\n"..
                    "// Define Sprite structure\n"..
                    "#ifndef _H_SPRITESTRUCT\n"..
                    "#define _H_SPRITESTRUCT\n\n"..
                    "struct Sprite\n"..
                    "{\n"..
                    "    const uint16_t frameCount;\n"..
                    "    const uint16_t width;\n"..
                    "    const uint16_t height;\n"..
                    "    const uint32_t *frameduration;\n"..
                    "    const uint32_t *frames;\n"..
                    "};\n\n"..
                    "#endif\n"

    local name = ("/DEADBEEF/"..dlg.data.File):match("^.+/([^.]+).+$"):gsub(" ","_")


    -- local fps_define =  "#define "..name:upper().."_FPS 5"
    -- local frame_count_define = "#define "..name:upper().."_FRAME_COUNT "..frame_count
    -- local width_define = "#define "..name:upper().."_FRAME_WIDTH "..w
    -- local height_define = "#define "..name:upper().."_FRAME_HEIGHT "..h

    -- Add to exported text
    local file_text = "";
    local frametime_text = "";
    local framepixels_text = "";

    file_text = file_text..header.."\n"
    --file_text = file_text..fps_define.."\n"
    -- file_text = file_text..frame_count_define.."\n"
    -- file_text = file_text..width_define.."\n"
    -- file_text = file_text..height_define.."\n"
    file_text = file_text.."\n/* Data exported for "..name.."*/\n"

    local variable_dec = "static const uint32_t PROGMEM "..name:lower().."_data["..frame_count.."]["..h*w.."] = {"
    framepixels_text = framepixels_text..variable_dec.."\n"

    frametime_text = "static const uint32_t PROGMEM "..name:lower().."_frameduration["..frame_count.."] = {"

    -- Img ofset. There is only one because we flattened the sprite
    local img_x = image.cel.bounds.x
    local img_y = image.cel.bounds.y
    --print("img offset = ("..img_x..","..img_y..")")

    -- For every frame
    for frameidx,frame in ipairs(sprite.frames) do
      -- Define w*h output array
      local output_array = {}
      for i = 0, w * h - 1 do
        output_array[i] = 0;
      end
      framepixels_text = framepixels_text.."{\n"
      app.activeFrame = frameidx;

      frametime_text = frametime_text..math.floor(frame.duration*1000)..", "

      image = app.activeImage
      -- For every pixel in the image, put it in the array
      for it in image:pixels() do
          local pixelValue = it() -- get pixel
          -- print("("..it.x..","..it.y..") = "..pixelValue)
          output_array[(it.x+img_x)+(w*(it.y+img_y))] = pixelValue;
      end

      for i = 0, w * h - 1 do
        local pixelValue = output_array[i];
        local pixel_str = string.format("0x%02X%02X%02X%02X", app.pixelColor.rgbaA(pixelValue),app.pixelColor.rgbaR(pixelValue),app.pixelColor.rgbaG(pixelValue),app.pixelColor.rgbaB(pixelValue))
        framepixels_text = framepixels_text..pixel_str
        if((i+1) % w ~= 0)
        then
          framepixels_text = framepixels_text..", "
        else
          framepixels_text = framepixels_text..",\n"
        end
      end
        -- Remove last comma
        framepixels_text = framepixels_text:sub(1, -3)
        framepixels_text = framepixels_text.."\n},".."\n"
      if(frame.next == nil)
      then
        framepixels_text = framepixels_text:sub(1, -3)
        framepixels_text = framepixels_text.."\n};\n"

        frametime_text = frametime_text:sub(1, -3)
        frametime_text = frametime_text.."};\n"
      end
    end

    file_text = file_text..frametime_text.."\n"..framepixels_text

    file_text = file_text..
    "const Sprite "..name.." PROGMEM = {\n"..
    "    "..frame_count..", // Frames\n"..
    "    "..w..", // Width\n"..
    "    "..h..", // Height\n"..
    "    &("..name:lower().."_frameduration[0]), // Frames duration\n"..
  "    &("..name:lower().."_data[0][0]) // Frames Data\n"..
  "};\n"

  -- print(file_text)
  filewrite = io.open(dlg.data.File, "w")
  filewrite:write(file_text)
  filewrite:close()
  dlg:close()
end }

dlg:show()
sprite:close();