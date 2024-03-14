
local ox_inventory = exports.ox_inventory
local locales = Config.Locales[Config.Language]

exports('open', function(data1, data2)
    local meta = data2.metadata
    if json.encode(meta) == '[]' then 
        write()
    else 
        read(meta)
    end 
end)
    
function write()
    local options = {}
    for k,v in pairs(Config.Documents) do 
        table.insert(options, {value = v.id, label = v.name})
    end 


    local input = lib.inputDialog(Config.Create.header, {
        {type = 'select', label = Config.Create.choose, options = options},
    })
    if input ~= nil then 
        createDoc(input[1])
    end 
end

function createDoc(docType)
    ESX.TriggerServerCallback('fdocs:getJob', function(xJob, xName)  
        for k,v in pairs(Config.Documents) do 
            if v.id == docType then 
                editBody(xJob, xName, k)
            end 
        end 
    end)
end 

function editBody(xJob, xName, xBody)
    local body = Config.Documents[xBody].body
    local settings = {}
    local docName = Config.Documents[xBody].name

    for k,v in pairs(body) do 
        if v.type == 'text' then 
            table.insert(settings, {required = true, type = 'input', label = v.name})
        end
        if v.type == 'date' then 
            table.insert(settings, {required = true, type = 'input', label = v.name, description = 'Format: DD.MM.YYYY'})
        end 
        if v.type == 'info' then 
            table.insert(settings, {required = true, type = 'textarea', label = v.name, min = v.lines, autosize = true})
        end 
        if v.type == 'sign' then 
            table.insert(settings, {type = 'checkbox', label = v.name, checked = v.presigned})
        end 
    end 

    local input = lib.inputDialog(Config.Create.header, settings)
    if input ~= nil then 
        setMeta(input, xJob, xName, xBody, docName)
    end 
end 

function setMeta(input, xJob, xName, xBody, docName)
    local body = Config.Documents[xBody].body
    local texts = {}

    table.insert(texts, {type = 'header', heading = docName, value = ''})

    for k,v in pairs(body) do 
        if v.type == 'sign' then 
            if input[k] == true then 
                table.insert(texts, {type = v.type, heading = v.name, value = (xName .. ' - ' .. xJob.label..' : ' .. xJob.grade_label)})
            else 
                table.insert(texts, {type = v.type, heading = v.name, value = 'n/A'})
            end 
        else 
            table.insert(texts, {type = v.type, heading = v.name, value = input[k]})
        end 
    end 

    local metadata = {}
    metadata.text = texts
    metadata.description = (Config.Meta.description):format(xName)
    metadata.label = docName

    print(json.encode(meta, {indent = true}))
    TriggerServerEvent('fdocs:add', metadata)
    Config.Notifcation(locales['doc_created'])
end

function read(meta)
    Config.Notifcation(locales['doc_opened'])
    local text = ''

    for k,v in pairs(meta.text) do 
        if v.type ~= 'header' then 
            text = text .. (v.heading .. '  \n')
            text = text .. (v.value .. '  \n\n')
        end 
    end 

    local alert = lib.alertDialog({
        header = meta.text[1].heading,
        content = text,
        centered = true,
        cancel = false,
        labels = {
            confirm = 'Schließen',
        }
    })
end
