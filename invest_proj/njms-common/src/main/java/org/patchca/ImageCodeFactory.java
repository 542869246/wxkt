package org.patchca;
import java.awt.Color;  
import java.awt.Graphics;  
import java.awt.image.BufferedImage;  
import java.awt.image.BufferedImageOp;  
import java.util.ArrayList;  
import java.util.List;  
import java.util.Random;  

import org.patchca.background.BackgroundFactory;
import org.patchca.color.RandomColorFactory;
import org.patchca.filter.ConfigurableFilterFactory;
import org.patchca.filter.library.AbstractImageOp;
import org.patchca.filter.library.WobbleImageOp;
import org.patchca.font.RandomFontFactory;
import org.patchca.service.ConfigurableCaptchaService;
import org.patchca.text.renderer.BestFitTextRenderer;
import org.patchca.word.RandomWordFactory;

/**
 * 图片验证码生成工厂
 * <br/>使用方法：
 * <br/>OutputStream outputStream = response.getOutputStream();  
 * <br/>Captcha captcha = ImageCodeFactory.getInstance().setCodeParams(120,45).getCaptcha(); 
 * <br/>System.out.println("code:"+captcha.getChallenge());
 * <br/>BufferedImage bufferedImage = captcha.getImage();  
 * <br/>ImageIO.write(bufferedImage, "png", outputStream);  
 * <br/>outputStream.flush();  
 * <br/>outputStream.close();
 * @author tlh
 * @date 2016年6月3日
 * @version 1.0
 *
 */
public class ImageCodeFactory {
	
	private ImageCodeFactory(){};
	private ConfigurableCaptchaService configurableCaptchaService = new ConfigurableCaptchaService();
	
	/**颜色创建工厂,使用一定范围内的随机色*/  
	private RandomColorFactory colorFactory = new RandomColorFactory();
	/**随机字体生成器*/
	private RandomFontFactory fontFactory = new RandomFontFactory();
	/**随机字符生成器,去除掉容易混淆的字母和数字,如o和0等*/
    private RandomWordFactory wordFactory = new RandomWordFactory();
    /**自定义验证码图片背景*/
    private MyCustomBackgroundFactory backgroundFactory = new MyCustomBackgroundFactory();
    /**图片滤镜设置*/
    private ConfigurableFilterFactory filterFactory = new ConfigurableFilterFactory();
    /**文字渲染器设置*/
    private BestFitTextRenderer textRenderer = new BestFitTextRenderer();
	
	private static ImageCodeFactory instance;
	
	public static ImageCodeFactory getInstance(){
		if(null==instance){
			instance = new ImageCodeFactory();
		}
		return instance;
	}
	
	/**
	 * 设置验证码参数
	 * @param width -> 图片高度
	 * @param height -> 图片宽度
	 * @return ->ConfigurableCaptchaService对象
	 */
	public ConfigurableCaptchaService setCodeParams(int width, int height){

        configurableCaptchaService.setColorFactory(colorFactory);  
          

        int font_maxSize = (int)(new Double(height)-new Double(height)*0.2);//最大字体
        int font_minSize = (int)(new Double(font_maxSize)*0.6);//最小字体
        fontFactory.setMaxSize(font_maxSize);  
        fontFactory.setMinSize(font_minSize);  
        configurableCaptchaService.setFontFactory(fontFactory);  
          

    	wordFactory.setCharacters("0123456789");  
    	wordFactory.setMaxLength(5);
    	wordFactory.setMinLength(4);  
    	configurableCaptchaService.setWordFactory(wordFactory);  
          
        configurableCaptchaService.setBackgroundFactory(backgroundFactory);  
          
        List<BufferedImageOp> filters = new ArrayList<BufferedImageOp>();  
        WobbleImageOp wobbleImageOp = new WobbleImageOp();  
        wobbleImageOp.setEdgeMode(AbstractImageOp.EDGE_MIRROR);  
        wobbleImageOp.setxAmplitude(6.0);  
        wobbleImageOp.setyAmplitude(6.0);  
        
        filters.add(wobbleImageOp);  
        filterFactory.setFilters(filters);  
        
        configurableCaptchaService.setFilterFactory(filterFactory);  


          
        textRenderer.setBottomMargin(3);  
        textRenderer.setTopMargin(3);  
        
        configurableCaptchaService.setTextRenderer(textRenderer);  

        // 验证码图片的大小  
        configurableCaptchaService.setWidth(width);  
        configurableCaptchaService.setHeight(height); 
        
        return configurableCaptchaService;
	}
}

/** 
 * 自定义验证码图片背景,主要画一些圆和干扰线 
 */  
class MyCustomBackgroundFactory implements BackgroundFactory {  

    private Random random = new Random(); 

	public void fillBackground(BufferedImage image) {  

        Graphics graphics = image.getGraphics();  

        // 验证码图片的宽高  
        int imgWidth = image.getWidth();  
        int imgHeight = image.getHeight();  

        // 填充为白色背景  
        graphics.setColor(Color.WHITE);  
        graphics.fillRect(0, 0, imgWidth, imgHeight);  

        // 画圆(颜色及位置随机) 
        int image_cubage = imgWidth*imgHeight;//整张图片面积
        int circle_count = (int)(new Double(image_cubage)*0.2);//噪点容积占总图片面积20%
        int single_circle_max_cubage = (int) (image_cubage*0.05);//生成的单个圆最大圆面积；为总面积的5%
        int single_circle_min_cubage = (int) (image_cubage*0.01);//生成的单个圆最小圆面积；为总面积的1%
        int loopIndex = (int)circle_count/single_circle_min_cubage/3;

        for(int i = 0; i < loopIndex; i++) {  
            // 随机颜色  
            int rInt = random.nextInt(233);  
            int gInt = random.nextInt(255);  
            int bInt = random.nextInt(244); 

            graphics.setColor(new Color(rInt, gInt, bInt));  

            // 随机位置  
            int xInt = random.nextInt(imgWidth - 3);  
            int yInt = random.nextInt(imgHeight - 2);  

            // 随机旋转角度  
            int sAngleInt = 360;  
            int eAngleInt = 360;  

            // 随机大小  
            int circle_max_cubage = random.nextInt(single_circle_max_cubage);//使用随机函数随机出圆的最大面积的随机数
            int circle_min_cubage = random.nextInt(single_circle_min_cubage);//使用随机函数随机出圆的最小面积的随机数
            int circle_avg_cubage = (int)(circle_max_cubage+circle_min_cubage)/2;//得出圆的平均随机面积
            int circle_avg_diameter = (int)(new Double(circle_avg_cubage)/3.14/2);//计算圆的直径
            int wInt = circle_avg_diameter;  
            int hInt = circle_avg_diameter;  

            graphics.fillArc(xInt, yInt, wInt, hInt, sAngleInt, eAngleInt);  

            // 画干扰线 ,占总画出的圆的数量的５0%
            if (i % 2 == 0) {  
                int xInt2 = random.nextInt(imgWidth);  
                int yInt2 = random.nextInt(imgHeight);  
                graphics.drawLine(xInt, yInt, xInt2, yInt2);  
            }  

        }  

    }  

}  