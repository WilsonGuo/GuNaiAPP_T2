

#ifndef _USER_INTERFACE_H_
#define _USER_INTERFACE_H_

typedef signed char     int8;
typedef signed  short   int16;
typedef signed int  int32;

typedef unsigned char   uint8;
typedef unsigned short   uint16;
typedef unsigned int     uint32;

typedef unsigned int     boolean;


int UserInit(unsigned  int app_id, uint32 group_id, uint8 *check_byte);
int UserNetWorkExit(void);


int UserNetWorkPause(void);

int UserNetWorkResume(void);
int UserEntryScanMode(void);
int UserExitScanMode(void);

int UserAddDevie(unsigned int wifi_id);
int UserDelDevie(unsigned int wifi_id);

int UserActiveDevice(unsigned int wifi_id);
int UserDisActiveDevice(unsigned int wifi_id);

int UserApConfig(uint8 *ssid, uint32 ssid_len, uint8 *password, uint32 ps_len, uint32 add_wifi_flg);
int UserGetDeviceLinkStatus(unsigned int wifi_id);

int UserGetServiceLinkStatus(void);

int UserSendData(unsigned int wifi_id, uint16 datalen, uint8 *data);



//uint32 SendMsgToUi(int msgType, unsigned int wifi_id, uint8* buff, int len);

#define  MAIN_MSG_TYPE_GET_APP_SN     (0)

#define  MAIN_MSG_TYPE_DATA   (1)


#define  MAIN_MSG_TYPE_NETWORK_UP  (2)



#define  MAIN_MSG_TYPE_NETWORK_DOWN  (3)


#define  MAIN_MSG_TYPE_FIND_NEW_WIFI_DEV (4)

//#define  MAIN_MSG_TYPE_MISS_NEW_WIFI_DEV (5)


//#define  MAIN_MSG_TYPE_ADD_NEW_WIFI_DEV_SUCCESS  (6)


#define  MAIN_MSG_TYPE_DEL_WIFI_DEV_SUCCESS     (7)


#define  MAIN_MSG_TYPE_SET_WIFI_PASSWORD_SUCCESS     (8)

#endif

