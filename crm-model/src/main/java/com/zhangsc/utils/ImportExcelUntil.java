package com.zhangsc.utils;

import org.apache.commons.lang3.reflect.FieldUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.*;

/** 
 *  
 * @author XiongYC 
 * @date 2017年11月2日 
 * 
 */  
public class ImportExcelUntil{
  
    /** 
     * 拼装单个obj 
     * @param obj 
     * @param row 
     * @return 
     * @throws Exception 
     */  
    private  static  Map<String, Object>  dataObj(Object obj, HSSFRow row) throws Exception {  
        Class<?> rowClazz= obj.getClass();      
        Field[] fields = FieldUtils.getAllFields(rowClazz);  
        if (fields == null || fields.length < 1) {  
            return null;  
        }  
          
        //容器  
        Map<String, Object> map = new HashMap<String, Object>();  
          
        //注意excel表格字段顺序要和obj字段顺序对齐 （如果有多余字段请另作特殊下标对应处理）  
        for (int j = 0; j < fields.length; j++) {  
            map.put(fields[j].getName(), getVal(row.getCell(j)));  
        }  
        return map;   
    }  
      
    public  static   List<Map<String, Object>> importExcel(MultipartFile file, Object obj) throws Exception {  
          
        //装载流  
        POIFSFileSystem fs = new POIFSFileSystem(file.getInputStream());  
        HSSFWorkbook hw= new HSSFWorkbook(fs);  
          
        //获取第一个sheet页  
        HSSFSheet sheet = hw.getSheetAt(0);  
          
        //容器  
        List<Map<String, Object>> ret = new ArrayList<Map<String, Object>>();  
          
        //遍历行 从下标第一行开始（去除标题）  
        for (int i = 1; i < sheet.getLastRowNum(); i++) {  
            HSSFRow row= sheet.getRow(i);  
            if(row!=null){  
                //装载obj  
                 ret.add(dataObj(obj,row));  
            }  
        }  
        return ret;  
    }  
      
    /** 
     * 处理val（暂时只处理string和number，可以自己添加自己需要的val类型） 
     * @param hssfCell 
     * @return 
     */  
    public static String getVal(HSSFCell hssfCell) {  
        if (hssfCell.getCellType() == HSSFCell.CELL_TYPE_STRING) {  
            return hssfCell.getStringCellValue();  
        } else {  
            return String.valueOf(hssfCell.getNumericCellValue());  
        }  
    }
    
    
    /**
     * 
     * <DL>
     * <DD>读取Excel的内容，第一维数组存储的是一行中格列的值，二维数组存储的是多少个行.</DD><BR>
     * </DL>
     * @author Angma <ZhouPeng>
     * @date 2017年3月27日
     * @param file    读取数据的源Excel文件
     * @return 读出的Excel中数据的内容     FileNotFoundException  IOException
     */
    public static String[][] getExcelData(MultipartFile file) {
        List<String[]> result = new ArrayList<String[]>();
        int rowSize = 0;
        InputStream in;
        try {
            in = file.getInputStream();
            // 打开HSSFWorkbook
            //POIFSFileSystem fs = new POIFSFileSystem(in);
            Workbook wb = null;
            String filePostFix = getFilePostFix(file.getOriginalFilename());
            if("XLS".equals(filePostFix)){
                wb = new HSSFWorkbook(in);//解析xls格式  
            }else if("XLSX".equals(filePostFix)){
                wb = new XSSFWorkbook(in);//解析xlsx格式  
            }
            Cell cell = null;
            Sheet st = wb.getSheetAt(0);
            // 第一行为标题，不取
            for (int rowIndex = 1; rowIndex <= st.getLastRowNum(); rowIndex++) {
                Row row = st.getRow(rowIndex);
                if (row == null) {
                    continue;
                }
                int tempRowSize = row.getLastCellNum();
                if (tempRowSize > rowSize) {
                    rowSize = tempRowSize;
                }
                String[] values = new String[rowSize];
                Arrays.fill(values, "");
                boolean hasValue = false;
                for (short columnIndex = 0; columnIndex < row
                        .getLastCellNum(); columnIndex++) {
                    String value = "";
                    cell = row.getCell(columnIndex);
                    if (cell != null) {
                        // 注意：一定要设成这个，否则可能会出现乱码
                        // cell.setEncoding(HSSFCell.ENCODING_UTF_16);
                        cell.setCellType(Cell.CELL_TYPE_STRING);
                        switch (cell.getCellType()) {
                            case Cell.CELL_TYPE_STRING:
                                value = cell.getStringCellValue();
                                break;
                           /* case Cell.CELL_TYPE_NUMERIC:
                                if (DateUtil.isCellDateFormatted(cell)) {
                                    Date date = cell.getDateCellValue();
                                    if (date != null) {
                                        value = new SimpleDateFormat(dateFormat).format(date);
                                    } else {
                                        value = "";
                                    }
                                } else{
                                    value = String.valueOf(cell.getNumericCellValue());
                                }
                                break;*/
                            case Cell.CELL_TYPE_FORMULA:
                                // 导入时如果为公式生成的数据则无值
                                if (!cell.getStringCellValue().equals("")) {
                                    value = cell.getStringCellValue();
                                } else {
                                    value = cell.getNumericCellValue() + "";
                                }
                                break;
                            case Cell.CELL_TYPE_BLANK:
                                break;
                            case Cell.CELL_TYPE_ERROR:
                                value = "";
                                break;
                            case Cell.CELL_TYPE_BOOLEAN:
                                value = (cell.getBooleanCellValue() == true ? "true"
                                        : "false");
                                break;
                            default: value = "";
                        }
                    }
                    values[columnIndex] = rightTrim(value);
                    hasValue = true;
                }
                if (hasValue) {
                    result.add(values);
                }
            }
            in.close();
        } catch(FileNotFoundException e) {
            throw new RuntimeException("未找到对应文件.");
        } catch(IOException ex) {
            throw new RuntimeException("文件读写失败.");
        }
        String[][] returnArray = new String[result.size()][rowSize];
        for (int i = 0; i < returnArray.length; i++) {
            returnArray[i] = (String[]) result.get(i);
        }
        System.out.println("返回的数据 ==> [ " + returnArray.toString() + "]");
        return returnArray;

    }
    /**
     * 
     * <DL>
     * <DD>去掉字符串右边的空格.</DD><BR>
     * </DL>
     * @author Angma <ZhouPeng>
     * @date 2017年3月27日
     * @param str 要处理的字符串
     * @return 处理后的字符串
     */
    public static String rightTrim(String str) {
        if (str == null) {
            return "";
        }
        int length = str.length();
        for (int i = length - 1; i >= 0; i--) {
            if (str.charAt(i) != 0x20) {
                break;
            }
            length--;
        }
        return str.substring(0, length);
    }
    
    /**
     * 
     * <DL>
     * <DD>获取文件后缀名.</DD><BR>
     * </DL>
     * @author Angma <ZhouPeng>
     * @date 2017年3月27日
     * @param fileName  文件名
     * @return 大写后缀名
     */
    public static String getFilePostFix(String fileName){
        String temp = fileName.substring(fileName.lastIndexOf(".")+1);
        if(temp!=null){
            return temp.toUpperCase();
        }else{
            return null;
        }
    }
} 