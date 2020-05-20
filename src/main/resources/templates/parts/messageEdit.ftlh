<h2></h2>
<form method="post" enctype="multipart/form-data">
    <div class="form-group row">
        <input type="text" name="text" class="form-control col s10 validate ${(textError??)?string('invalid', '')}" value="<#if message??>${message.text}</#if>" id="messageInput" placeholder="Enter your message...">
        <span class="helper-text" data-error="${textError!}" data-success="right"></span>
        <button class="waves-effect waves-light btn col s2" type="submit"><i class="material-icons">send</i></button>
    </div>
    <div class="form-group row">
        <input type="text" name="tag" class="form-control col s12 validate ${(tagError??)?string('invalid', '')}" value="<#if message??>${message.tag}</#if>" id="tagInput" placeholder="Enter your tag...">
        <span class="helper-text" data-error="${tagError!}" data-success="right"></span>
    </div>
    <div class="file-field input-field last-form-div row">
        <div class="btn col s2">
            <span>File</span>
            <input type="file" name="file">
        </div>
        <div class="file-path-wrapper">
            <input class="file-path validate" type="text" placeholder="Upload file">
        </div>
    </div>
    <input type="hidden" name="id" value="<#if message??>${message.id}</#if>" />
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
</form>