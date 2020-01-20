### 합성곱 신경망(CNN)

> CNN은 이미지 인식과 음성 인식 등 다양한 곳에서 사용되며, 
>
> 특히 이미지 인식 분야에서 딥러닝을 활용한 기법은 거의 CNN을 기초로 한다.
>
> → CNN의 매커니즘을 자세히 설명하고 이를 파이썬으로 구현해보자 



#### 1. 전체 구조 

> * Affine계층
>
> 지금까지 배운 신경망은 인접하는 계층의 모든 뉴런과 결합되어 있다. 
>
> → 이를 '완전연결(Fully-Connected, 전결합)' 이라 지칭한다. 
>
> → 완전히 연결된 계층을 'Affine 계층' 이라는 이름으로 구현한다. 
>
> 완전연결 신경망은 Affine 계층 뒤에 활성화 함수를 갖는 ReLU(또는 Sigmoid)계층이 이어진다.
>
> → 마지막 계층은 Affine계층에 이어 Softmax계층이 이어지며 최종결과(확률)를 출력한다. 
>
> * 합성곱 계층 & 풀링 계층
>
> CNN에서는 새로운 계층이 '합성곱(convolution)' 계층과 '풀링(Pooling)' 계층이 추가된다. 
>
> → CNN 계층은 'Conv-ReLU-(Pooling)' 의 흐름으로 연결된다.(Pooling은 불필요시 생략)
>
> → 'Affine-Relu' 에서 'Conv-ReLU-(Pooling)' 로 변화 
>
> 또한, 출력이 가까운 층에서는 지금까지의 Affine-Relu 구성을 사용할 수 있다.
>
> 마지막 출력 계층에서는 Affine-Softmax 조합을 그대로 사용한다. 
>
> ![완전연결 계층과 합성곱 계층](.\완전연결 계층과 합성곱 계층.png)

#### 2. 합성곱 계층 

> - 완전 연결 계층의 문제점 
>
> > * 완전 연결 계층은  '데이터의 형상이 무너진다' 는 단점이 있음. 
> >
> > : 대표적으로 이미지 데이터 → 세로, 가로, 채널(색상) 로 구성된 '3차원 데이터'
> >
> > * 그러나 기존 사례에서는 1차원으로 펴낸 데이터로 입력  
> >
> > (ex/ mnist → (1,28,28) 1채널, 세로 28픽셀, 가로 28픽셀을 1줄로 세운 784개 데이터化) 
> >
> > * 기존 이미지데이터는 3차원 형상으로서 갖는 고유한 정보들이 담겨있음
> >
> > (ex/ 공간적으로 같은 픽셀은 값이 비슷하다, 거리가 먼 픽셀끼리는 별 연관이 없다, 
> >
> > ​        RGB의 각 채널은 서로 밀접한 연관성이 있을 수 있다 etc....)
> >
> > * 완전연결 계층은 이러한 3차원 속에서 의미를 갖는 본질적인 패턴을 놓치고 모든 입력 데이터를 동등한 뉴런으로 취급하여 형상이 담긴 정보를 살릴 수 없음! 
<<<<<<< HEAD
>
> ↔ 반면 ''합성 곱 계층'' 은 형상을유지한다! 
>
> ​     이미지처럼 형상을 가진 데이터를 제대로 이해가능
>
> ​	 (이미지를 3차원으로 입력받고 다음 계층에도 3차원으로 전달 )
>
> * 특징 맵(Feature map)
>
> > CNN에서는 합성 곱 계층의 입출력 데이터를 '특징 맵(feature map)' 으로 지칭한다. 
> >
> > 합성곱 계층의 입력 데이터를 입력(input) 특징 맵, 출력 데이터를 출력(output) 특징 맵이라 함. 
>
> * 합성 곱 연산 
>
> > * 합성곱 연산 → 필터 연산(이미지 처리)
> >
> > ![합성곱 연산](../../../../TIL/TIL/image/합성곱 연산-1579238797960.png)
> >
> > * 합성 곱 연산은 입력 데이터에 필터를 적용한다. 입력 데이터와 필터는 '높의, 너비' 의 차원 존재
> > * (ex/ 입력은(4, 4), 필터는(3, 3), 출력은(2, 2))
> > * 문헌에 따라 필터를 커널이라 지칭하기도 함. 
=======
> >
> > > ↔ 반면, 합성곱 계층은 형상을 유지하며, 이미지의 3차원을 유지하고 다음 계층에도 3차원의 데이터로 전달한다. 
> > >
> > > 합성곱 계층의 입출력 데이터는 **특징 맵(feature map)** 이라고 하며, 입력 데이터를 **입력 특징 맵(input feature map), ** 출력 데이터를 **출력 특징 맵(output feature map)**이라고 지칭한다. 
>
> * 합성곱 연산 
>
> > * 합성곱 연산 = (이미지 처리에서의) **필터연산**
> >
> > ![필터연산](.\필터연산.png)
> >
> > * 합성곱 연산은 입력 데이터에 필터를 적용하는 형태로 연산된다. 이때, 입력 데이터와 필터는       (**높이width, 너비height**) 의 형상을 가진다(2차원).
> >
> > * (Ex/ 입력데이터 (4, 4) , 필터(3, 3), 출력(2, 2) )
> >
> > * 필터는 다른 말로 **커널(kernal)** 이라고도 지칭한다. 
> >
> > * 합성곱 연산은 필터의 **윈도우**를 일정간격으로 이동해가며 입력 데이터에 적용한다.  입력과 필터에서 대응하는 원소끼리 곱한 후 그 총합을 구하는 **단일 곱셈 누산(FMA)**이 이루어진다. 
> >
> > * 단일 곱셈 누산의 결과를 출력의 해당 장소에 저장함으로서 연산이 완성된다. 
> >
> >   ![합성곱 연산의 계산순서](.\합성곱 연산의 계산순서.png)
> >
> > * CNN에서는 필터의 매개변수가 '가중치(w)'에 해당하며  '편항(bias)' 역시 존재한다. 
> >
> >   (편향은 항상 하나만 존재(1x1))
> >
> > ![합성곱 연산의 편향](D:\Home\Rhee\python_projects(in .txt)\20200114_제 38강(CNN개요)\합성곱 연산의 편향.png)
>
> * 패딩(Padding)
>
> > * 합성곱 연산에서 (주로)출력 크기를 조정할 목적으로 데이터 주변을 특정값(0) 으로 채우는 기법.
> > * 합성곱 연산을 거듭하면 출력이 크기가 점점 줄어들어(최종적으로 1) 더이상 연산을 수행할 수 없는것을 막기 위함 
> >
> >  <img src=".\패딩.png" alt="패딩" style="zoom:150%;" />
>
> * 스트라이드(stride)
>
> > * 필터를 적용하는 위치의 간격을 지칭. 윈도우의 이동 범위 
> > * 스프라이드의 크기를 키우면 출력의 크기는 작아진다. ↔ 패딩 
> >
> > * 예제 : 입력을 (H, W), 필터가 (FH, FW), 출력이 (OH, OW), 패딩이 P,  스트라이드가 S라고 할때 
> >
> > > OH = (H + 2P - FH) / S +1
> > >
> > > OW =(W + 2P - FW)/S +1						(*패딩과 스트라이드의 역 상관관계)\
> >
> > > 예1: 입력 (4, 4),  패딩 1,  스트라이드 1, 필터 (3,3)
> > >
> > > OH = (4 + 2*1 -3) / 1 + 1 = 4
> > >
> > > OW = (4 + 2*1 - 3) / 1 + 1 = 4					출력(4, 4)
> > >
> > > 예2:  입력 (7, 7),  패딩 0,  스트라이드 2, 필터 (3,3)
> > >
> > > OH = (7 + 2*0 -3) / 2 + 1 = 3
> > >
> > > OW = (7 + 2*0 -3) / 2 + 1 = 3					출력(3, 3)
> > >
> > > 예3:  입력 (28, 31),  패딩 2,  스트라이드 3, 필터 (5,5)
> > >
> > > OH = (28 + 2*2 - 5) / 3 + 1 = 10
> > >
> > > OW = (31 + 2*2 -5) /3 + 1 = 11				 출력(10, 11)
> >
> > * 출력 크기가 정수가 아니면 오류를 내주는 등의 대응이 필요하다.(원소의 개수니깐 당연히 정수)
> > * 3차원 데이터의 합성곱 연산 
> >
> > ![3차원 데이터의 합성곱 연산](.\3차원 데이터의 합성곱 연산.png)
> >
> > : 2차원 연산과 비교하여 길이 방향(채널 방향)으로 특정 맵이 증가 
> >
> >   입력 데이터와 필터의 합성곱 연산을 채널마다 수행하고, 그 결과를 더해서 하나의 출력을 얻음. 
> >
> >   (입력 데이터의 채널 수와 필터의 채널 수가 같고, 모든 채널의 필터크기가 같아야 성립) 
> >
> > * 블록으로 생각하기(연산을)
> >
> > ![3차원 데이터의 합성곱 연산2](.\3차원 데이터의 합성곱 연산2.png)
> >
> > * 상태의 표기는 (높이, 너비, 채널 수) 가 된다. 
> > * 필터를 FN개 적용하면 출력 맵도 FN개가 생겨나게 된다. 
> > * FN개의 맵을 모으면 형상이 (FN, OH, OW)인 블록이 완성된다. 
> >
> > (위 완성된 블록을 다음 계층으로 넘기겠다는 것이 CNN의 처리 흐름)
> >
> > * 편향은 (FN, 1, 1)의 구조를 갖는다. 
> >
> > * 완전연결 신경망처럼, 합성곱 연산도 배치 처리를 할 수 있다.
> >
> >   (1개 차원 증가, → (데이터 수, 채널 수, 높이, 너비) 순으로 저장)
> >
> > ![합성곱 연산의 처리 흐름(배치처리)](.\합성곱 연산의 처리 흐름(배치처리).png)
> >
> > * 신경망 계산시 데이터는 4차원 형상을 가진 채 각 계층을 타고 흐른다.
> >
> >    → 신경망에 4차원 데이터가 하나 흐를 때 마다 데이터 N개가 합성곱 연산이 이루어진다. 
> >
> >   ​      (N회분의 처리를 한 번에 수행함)



#### 3. 풀링 계층

> 풀링은 세로, 가로 방향의 공간을 줄이는 연산 
>
> ![최대 풀링의 처리 순서](.\최대 풀링의 처리 순서.png)
>
> * **최대 풀링(max pooling)**은 대상 영역의 최댓값을 구하는 연산(주로 이미지)
>
> * 즉 2x2 최대 풀링은 그림과 같이 2x2 크기의 영역에서 가장 큰 원소 하나를 꺼냄
>
> * 스트라이드를 2로 설정했다면 그림처럼 2x2윈도우가 2칸 간격으로 이동함 
>
>   (풀링의 윈도우 크기와 스트라이는 같은 값으로 설정하는 것이 보통)
>
> * **평균 풀링(average pooling)**의 경우 대상 영역에서 평균을 계산하는 방식 

#### 4. 합성곱 / 풀링 계층 구현하기 

> * forward와 backward 메서드를 추가하여 모듈로 이용할 수 있도록 한다. 
> * im2col이라는 '트릭' 을 이용한다. 
>
> * 4차원 배열(to Python3)
>
> > * 높이 28. 너비 28, 채널 1개인 데이터가 10개 임을 python으로 구현 
>
> ```python
> x = np.random.rand(10, 1, 28, 28) #무작위로 데이터 생성 
> x.shape  #(10,1,28,28)
> 
> # 인덱스로 데이터에 접근하기(첫번째, 두번째 데이터) 
> x[0].shape #(1, 28, 28) 
> x[1].shape #(1, 28, 28)
> 
> # 첫번째 데이터의 첫 채널의 공간 데이터에 접근 
> x[0, 0] #또는 x[0][0]
> ```
>
> > CNN 은 4차원 데이터를 다룬다 → 합성곱 연산은 '복잡하다'
> >
> > 합성곱 연산을 곧이곧대로 구현하자면 for 문을 겹겹이 써야하나(넘파이 성능 저하)
> >
> > for 문 대신 **im2col** 이란 편의함수를 통해 간단하게 구현 가능하다. 
>
> * im2col(image to column) 함수
>
> > im2col은 입력 데이터를 필터링(가중치 계산) 하기 좋게 전개하는(펼치는) 함수
> >
> > : (배치batch한 데이터 수를 포함한) <u>4차원</u> 데이터를 → <u>2차원</u> 으로 변환 
> >
> > (※ Caffe나 Chainer등의 딥러닝 프레임워크는 구현하는 함수) 
> >
> > ![im2col,reshape](.\im2col,reshape.png)
> >
> > * im2col로 입력 데이터를 전개한 후, 합성곱 계층의 필터(가중치)를 1열로 전개하고, 두 행렬의 곱을 계산한다.(완전연결 계층의 Affine과 유사)
> > * CNN은 데이터를 4차원 배열로 저장하므로, 2차원인 풀력 데이터를 4차원으로 변형reshape 한다. (이상 합성곱 계층의 구현 흐름 끝.)
>
> * 합성곱 계층 구현하기 
>
> > * im2col 함수 (내부함수 10개 내포)
> >
> > (https://github.com/WegraLee/deep-learning-from-scratch/blob/master/common/util.py 참조)
> >
> > ```python
> > # coding: utf-8
> > import numpy as np
> > 
> > 
> > def smooth_curve(x):
> >     """손실 함수의 그래프를 매끄럽게 하기 위해 사용
> >     
> >     참고：http://glowingpython.blogspot.jp/2012/02/convolution-with-numpy.html
> >     """
> >     window_len = 11
> >     s = np.r_[x[window_len-1:0:-1], x, x[-1:-window_len:-1]]
> >     w = np.kaiser(window_len, 2)
> >     y = np.convolve(w/w.sum(), s, mode='valid')
> >     return y[5:len(y)-5]
> > 
> > 
> > def shuffle_dataset(x, t):
> >     """데이터셋을 뒤섞는다.
> >     Parameters
> >     ----------
> >     x : 훈련 데이터
> >     t : 정답 레이블
> >     
> >     Returns
> >     -------
> >     x, t : 뒤섞은 훈련 데이터와 정답 레이블
> >     """
> >     permutation = np.random.permutation(x.shape[0])
> >     x = x[permutation,:] if x.ndim == 2 else x[permutation,:,:,:]
> >     t = t[permutation]
> > 
> >     return x, t
> > 
> > def conv_output_size(input_size, filter_size, stride=1, pad=0):
> >     return (input_size + 2*pad - filter_size) / stride + 1
> > 
> > 
> > def im2col(input_data, filter_h, filter_w, stride=1, pad=0):
> >     """다수의 이미지를 입력받아 2차원 배열로 변환한다(평탄화).
> >     
> >     Parameters
> >     ----------
> >     input_data : 4차원 배열 형태의 입력 데이터(이미지 수, 채널 수, 높이, 너비)
> >     filter_h : 필터의 높이
> >     filter_w : 필터의 너비
> >     stride : 스트라이드
> >     pad : 패딩
> >     
> >     Returns
> >     -------
> >     col : 2차원 배열
> >     """
> >     N, C, H, W = input_data.shape
> >     out_h = (H + 2*pad - filter_h)//stride + 1
> >     out_w = (W + 2*pad - filter_w)//stride + 1
> > 
> >     img = np.pad(input_data, [(0,0), (0,0), (pad, pad), (pad, pad)], 'constant')
> >     col = np.zeros((N, C, filter_h, filter_w, out_h, out_w))
> > 
> >     for y in range(filter_h):
> >         y_max = y + stride*out_h
> >         for x in range(filter_w):
> >             x_max = x + stride*out_w
> >             col[:, :, y, x, :, :] = img[:, :, y:y_max:stride, x:x_max:stride]
> > 
> >     col = col.transpose(0, 4, 5, 1, 2, 3).reshape(N*out_h*out_w, -1)
> >     return col
> > 
> > 
> > def col2im(col, input_shape, filter_h, filter_w, stride=1, pad=0):
> >     """(im2col과 반대) 2차원 배열을 입력받아 다수의 이미지 묶음으로 변환한다.
> >     
> >     Parameters
> >     ----------
> >     col : 2차원 배열(입력 데이터)
> >     input_shape : 원래 이미지 데이터의 형상（예：(10, 1, 28, 28)）
> >     filter_h : 필터의 높이
> >     filter_w : 필터의 너비
> >     stride : 스트라이드
> >     pad : 패딩
> >     
> >     Returns
> >     -------
> >     img : 변환된 이미지들
> >     """
> >     N, C, H, W = input_shape
> >     out_h = (H + 2*pad - filter_h)//stride + 1
> >     out_w = (W + 2*pad - filter_w)//stride + 1
> >     col = col.reshape(N, out_h, out_w, C, filter_h, filter_w).transpose(0, 3, 4, 5, 1, 2)
> > 
> >     img = np.zeros((N, C, H + 2*pad + stride - 1, W + 2*pad + stride - 1))
> >     for y in range(filter_h):
> >         y_max = y + stride*out_h
> >         for x in range(filter_w):
> >             x_max = x + stride*out_w
> >             img[:, :, y:y_max:stride, x:x_max:stride] += col[:, :, y, x, :, :]
> > 
> >     return img[:, :, pad:H + pad, pad:W + pad]
> > ```
> >
> > * im2col함수의 인터페이스 
> >
> > ```python
> > im2col(input_data, filter_h, filter_w, stride=1, pad=0)
> > '''
> > input_data: (데이터수, 채널 수, 높이, 너비)의 3차원 배열로 이루어진 입력 데이터 
> > filter_h: 필터의 높이 
> > filter_W: 필터의 너비 
> > stride: 스트라이드
> > pad: 패딩
> > '''
> > ```
> >
> > * 사용 예시
> >
> > ``` python
> > import sys, os
> > sys.path.append(os.pardir)
> > from common.util import im2col
> > 
> > x1 = np.random.rand(1, 3, 7, 7) #(데이터 수, 채널 수, 높이, 너비)
> > col1 = im2col(x1, 5, 5, stride=1, pad=0)
> > print(col1.shape) #(9, 75)
> > 
> > x2 = np.random.rand(10, 3, 7, 7) #데이터 10개(batch)
> > col2 = im2col(x2, 5, 5, stride=1, pad=0)
> > print(col2.shape) #(90, 75)
> > ```
> >
> > * im2col 함수를 이용한 합성곱 계층 구현 
> >
> > ``` python
> > class defConvolution:
> >     def __init__(self, W, b, stride=1, pad=0):
> >         self.W = W
> >         self.b = b
> >         self.stride = stride
> >         self.pad = pad
> >         
> >     def forward(self, x):
> >         FN, C, FH, FW = self.W.shape
> >         N, C, H, W = x.shape
> >         out_h = int(1+ (H + 2*self.pad - FH) / self.stride)
> >         out_w = int(1+ (W + 2*self.pad - FW) / self.stride)
> >         
> >         col = im2col(x, FH, FW, self.stride, self.pad)
> >         col_W = self.W.reshape(FN, -1).T #필터 전개
> >         out = np.dot(col, col_W) + self.b
> >         
> >         out = out.reshape(N, out_h, out_w, -1).transpose(0, 3, 1, 2)
> >         
> >         return out 
> >     
> > ```
>>>>>>> 26f18a35f92fdc7b81717453e2740157bdefb16b
> >
> > 

 