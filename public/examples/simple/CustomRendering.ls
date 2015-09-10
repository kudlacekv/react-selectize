Form = React.create-class do 
    
    # render :: a -> ReactElement
    render: ->
        React.create-element SimpleSelect,
            options: @state.options
            placeholder: "Select a color"
            create-from-search: (options, search) ~> 
                return null if search.length == 0 or search in map (.label), options
                label: search, value: search
            on-value-change: ({label, value, new-option}?, callback) !~>
                if !!new-option
                    @set-state options: [{label, value}] ++ @state.options, callback 
            
            # render-option :: Int -> Item -> ReactElement
            render-option: (index, {label, new-option}?) ~>
                div do 
                    class-name: \simple-option
                    style: display: \flex, align-items: \center
                    div style: background-color: label, width: 24, height: 24, border-radius: \50%
                    div style: margin-left: 10, if !!new-option then "Add #{label}..." else label
            
            # render-value :: Int -> Item -> ReactElement
            render-value: (index, {label}) ~>
                div do 
                    class-name: \simple-value
                    style: display: \inline-block
                    span style: 
                        background-color: label, border-radius: \50%, 
                        vertical-align: \middle, width: 24, height: 24
                    span style: margin-left: 10, vertical-align: \middle, label
                
    get-initial-state: ->
        
        # random-color :: a -> String
        random-color = -> 
            [0 to 2] 
            |> map -> Math.floor Math.random! * 255
            |> -> it ++ (Math.round Math.random! * 10) / 10
            |> Str.join \,
            |> -> "rgba(#{it})"
            
        options: [0 til 10] |> map -> 
            color = random-color!
            label: color, value: color
                
React.render (React.create-element Form, null), mount-node