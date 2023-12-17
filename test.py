import cv2
import urllib.request
import numpy as np

url = 'http://192.168.0.112/cam-lo.jpg'



while(1):
    img=urllib.request.urlopen(url)
    img_np=np.array(bytearray(img.read()),dtype=np.uint8)
    frame=cv2.imdecode(img_np, -1)
    print(frame)
    cv2.imshow("img",frame)
    if cv2.waitKey(10) & 0xFF==ord('q'):
        frame.release()
        cv2.destroyAllWindows()
        break