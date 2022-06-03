local discordia = require('discordia')
local client = discordia.Client()

client:on('ready', function()
	print('Logged in as '.. client.user.username)

    client:setGame{type = 1, name= ' with the lights'}

    MessageContent = client:getChannel(io.open("./src/Data/channelid.txt"):read()):getMessage(io.open("./src/Data/messageid.txt"):read())


end)

client:on('messageCreate', function(message)

    if message.content == 'start' then

        MessageContent = message.channel:send("started")
        MessageContent:addReaction('⬜')
        MessageContent:addReaction('⬛')

    local file,err = io.open("./src/Data/messageid.txt",'w')
            if file then
                file:write(MessageContent.id)
                file:close()
            else
                print("error:", err)
            end

    else if message.content == 'setChannel' then

        local file,err = io.open("./src/Data/channelid.txt",'w')
            if file then
                file:write(tostring(message.channel.id))
                file:close()
            else
                print("error:", err)
            end
                message:reply(tostring("channel id: " .. message.channel.id))


        else if message.content == 'RESET' then

            if message.author.id ~= '346939348530495489' then return end
            local file,err = io.open("./src/Data/black.txt",'w')
            if file then
                file:write('0')
                file:close()
            else
                print("error:", err)
            end

            local file,err = io.open("./src/Data/white.txt",'w')
            if file then
                file:write('0')
                file:close()
            else
                print("error:", err)
                end

        else if message.content == 'ping' then

                message:reply('pong')

                end
            end
        end
    end
end)


client:on('reactionAdd', function (reaction)

        if reaction.message ~= MessageContent then return end

        if reaction.emojiName == '⬛' then  
           local file,err = io.open("./src/Data/black.txt",'w')
           if file then
               file:write(tostring(reaction.count))
               file:close()
           else
               print("error:", err)
           end


        else if reaction.emojiName == '⬜' then
            local file,err = io.open("./src/Data/white.txt",'w')
            if file then
                file:write(tostring(reaction.count))
                file:close()
            else
                print("error:", err)
            end
        end
    end

    if tonumber(io.open("./src/Data/black.txt"):read()) > tonumber(io.open("./src/Data/white.txt"):read()) then

        MessageContent:setContent("https://cdn.discordapp.com/attachments/966571367917060096/967293249515573318/unknown.png")

    else if tonumber(io.open("./src/Data/white.txt"):read()) > tonumber(io.open("./src/Data/black.txt"):read()) then

        MessageContent:setContent("https://cdn.discordapp.com/attachments/966571367917060096/966574653256638484/switchon.png")

            end
        end
end)


client:on('reactionRemove', function (reaction)

    if reaction.message ~= MessageContent then return end

    if reaction.emojiName == '⬛' then

        local file,err = io.open("./src/Data/black.txt",'w')
        if file then
            file:write(tostring(reaction.count))
            file:close()
        else
            print("error:", err)
        end


     else if reaction.emojiName == '⬜' then

        local file,err = io.open("./src/Data/white.txt",'w')
        if file then
            file:write(tostring(reaction.count))
            file:close()
        else
            print("error:", err)
        end


        end
    end

    if tonumber(io.open("./src/Data/black.txt"):read()) > tonumber(io.open("./src/Data/white.txt"):read()) then

        MessageContent:setContent("https://cdn.discordapp.com/attachments/966571367917060096/967293249515573318/unknown.png")


    else if tonumber(io.open("./src/Data/white.txt"):read()) > tonumber(io.open("./src/Data/black.txt"):read()) then

        MessageContent:setContent("https://cdn.discordapp.com/attachments/966571367917060096/966574653256638484/switchon.png")
            end
        end
end)


client:run("Bot "..io.open("./login.txt"):read())