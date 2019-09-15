<div class="collapse <#if message??>show</#if>" id="addMsgForm">
    <div class="form-group mt-3">
        <form method="post" enctype="multipart/form-data">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <div class="form-group">
                <input class="form-control ${(textError??)?string('is-invalid','')}" type="text"
                       name="text" value="<#if message??>${message.text}</#if>" placeholder="Введите сообщение">
                <#if textError??>
                    <div class="invalid-feedback">
                        ${textError}
                    </div>
                </#if>
            </div>
            <div class="form-group">
                <input class="form-control ${(tagError??)?string('is-invalid','')}" type="text"
                       name="tag" value="<#if message??>${message.tag}</#if>" placeholder="Введите тег">
                <#if tagError??>
                    <div class="invalid-feedback">
                        ${tagError}
                    </div>
                </#if>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file" id="customFile">
                    <label for="customFile" class="custom-file-label">Choose file</label>
                </div>
            </div>
            <div class="form-group">
                <button class="btn btn-primary " type="submit">Add message</button>
            </div>
        </form>
    </div>
</div>