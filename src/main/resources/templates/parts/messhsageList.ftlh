<h2></h2>
<#list messages as message>
    <div class="col s12 m12 l12">
        <div class="card">
            <div class="card-content">
                <span class="card-title">${message.id}</span>
                <p>${message.text}</p>
            </div>
            <div class="card-action">
                <div class="chip">
                    ${message.tag}
                </div>
                <p><i>${message.authorName}</i></p>
            </div>
            <#if message.filename??>
                <div class="card-image">
                    <img src="/img/${message.filename}" alt="">
                </div>
            </#if>
        </div>
    </div>
</#list>