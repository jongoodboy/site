package com.thinkgem.jeesite.mother.admin.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * Created by wangJH on 2018/1/11.
 * 使用说明
 */
public class Instructions extends DataEntity<Instructions> {
    private String instructionsContent;//使用说明内容
    private String createName;//创建人姓名
    private String updateName;//更新者姓名
    private Integer instructionsType;//使用说明类型,0使用说明,1如何成为会员2.购买流程

    public String getInstructionsContent() {
        return instructionsContent;
    }

    public void setInstructionsContent(String instructionsContent) {
        this.instructionsContent = instructionsContent;
    }

    public String getCreateName() {
        return createName;
    }

    public void setCreateName(String createName) {
        this.createName = createName;
    }

    public String getUpdateName() {
        return updateName;
    }

    public void setUpdateName(String updateName) {
        this.updateName = updateName;
    }

    public Integer getInstructionsType() {
        return instructionsType;
    }

    public void setInstructionsType(Integer instructionsType) {
        this.instructionsType = instructionsType;
    }
}
