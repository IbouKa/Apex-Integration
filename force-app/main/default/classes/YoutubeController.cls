public with sharing class YoutubeController {
    public String body {get;set;}
    public YoutubeSearch result {get;set;}
    public String searchQuery {get;set;}
    public Video[] videos {get;set;}
    public void search(){
        String key = API_Token__c.getInstance().YoutubeKey__c;//Get key in custom setting
        this.searchQuery=this.searchQuery.replaceAll(' ','+');
        String endpoint='callout:Youtube?part=snippet&q='+this.searchQuery+'&key='+key;
        videos=new List<Video>();
        Http http=new Http();

        HttpRequest request=new HttpRequest();
        request.setHeader('Accept', 'application/json');
        request.setEndpoint(endpoint);
        request.setMethod('GET');

        HttpResponse response=http.send(request);
        body=response.getBody();
        result= (YoutubeSearch)JSON.deserialize(body, YoutubeSearch.class);
        System.debug('result '+result); 
        System.debug('result '+result.items); 
      
            for (cls_items video : result.items) {
                videos.add(new video(video.snippet.title,video.snippet.description,video.snippet.publishTime,video.snippet.thumbnails.medium.url));
            }
        System.debug('result '+videos); 
        
    }

    public class YoutubeSearch{
        public String kind;	//youtube#searchListResponse
        public String etag;	//g-DRzehuJKX3VpW98e66NCl6Pxw
        public String nextPageToken;	//CAUQAA
        public String regionCode;	//US
        public cls_pageInfo pageInfo;
        public cls_items[] items;
    
    }
    class cls_pageInfo {
        public Integer totalResults;	//509
        public Integer resultsPerPage;	//5
    }
    class cls_items {
        public String kind;	//youtube#searchResult
        public String etag;	//KmvjfPvhtIv4yvG00lV75bZ3Gg0
        public cls_id id;
        public cls_snippet snippet;
    }
    class cls_id {
        public String kind;	//youtube#video
        public String videoId;	//v7bl_p87KMQ
    }
    class cls_snippet {
        public String publishedAt;	//2023-09-29T21:01:46Z
        public String channelId;	//UCv88VZJUuRoot7GfSO_sm-g
        public String title;	//Calling My Name [I&#39;m A Soldier] - Ebuka Songs [Live]
        public String description;	//There's a call that everyone must answer! There is a purpose of God for every man's life. It is one thing to recognise that God is ...
        public cls_thumbnails thumbnails;
        public String channelTitle;	//Moses Bliss
        public String liveBroadcastContent;	//none
        public String publishTime;	//2023-09-29T21:01:46Z
    }
    class cls_thumbnails {
        public cls_default default_x;
        public cls_medium medium;
        public cls_high high;
    }
    class cls_default {
        public String url;	//https://i.ytimg.com/vi/v7bl_p87KMQ/default.jpg
        public Integer width;	//120
        public Integer height;	//90
    }
    class cls_medium {
        public String url;	//https://i.ytimg.com/vi/v7bl_p87KMQ/mqdefault.jpg
        public Integer width;	//320
        public Integer height;	//180
    }
    class cls_high {
        public String url;	//https://i.ytimg.com/vi/v7bl_p87KMQ/hqdefault.jpg
        public Integer width;	//480
        public Integer height;	//360
    }
    class Video {
        public String title {get; set;}
        public String description {get; set;}
        public String url {get; set;}
        public String publishTime {get; set;}	

        public Video(String title,String description,String publishTime,String url){
            this.title=title;
            this.description=description;
            this.publishTime=publishTime;
            this.url=url;
        }
    }
}