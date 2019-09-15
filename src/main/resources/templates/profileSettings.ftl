<#import "parts/common.ftl" as c>
<@c.page>
    <h5>${username} Profile</h5>
    ${message?ifExists}
    <form method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}">




        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Password: </label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control" placeholder="Password"/>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Email: </label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control" placeholder="${email!''}"/>
            </div>
        </div>
        <input class="btn btn-primary" type="submit" value="Save"/>
    </form>
</@c.page>