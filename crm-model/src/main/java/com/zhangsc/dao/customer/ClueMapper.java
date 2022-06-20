package com.zhangsc.dao.customer;

import com.zhangsc.pojo.customer.TCusClue;
import com.zhangsc.pojo.customer.TCusClueCustom;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 线索mapper</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-03
 */
public interface ClueMapper {
    public List<TCusClueCustom> query(TCusClueCustom clue);

    public void save(TCusClue clue);

    public TCusClueCustom queryById(Long id);

    public void update(TCusClue clue);

    public void delete(Long id);

    public void autoBack(Integer remain);

    public void toPool(TCusClue clue);
    /*查询需要提醒的线索日程*/
    public List<TCusClueCustom> queryCluePlanRemind();

    public List<TCusClueCustom> queryClue(TCusClueCustom clue);

    public void updateStatus(TCusClue clue);
}
