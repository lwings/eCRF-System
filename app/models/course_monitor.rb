class CourseMonitor < ActiveRecord::Base
  require 'date'

  belongs_to :patient
  belongs_to :research_group


  before_save :set_overdue_course

  def set_overdue_course
    if self.patient.status.value!=1
      return
    end
    res=0
    scheduleChart=self.getScheduleChart
    curList=[self.record_phase_seq,self.record_course_seq,1,false,0]
    delayedDays=days_till_now(self.last_record_date)
    while delayedDays>0
      delayedDays-=1
      oldCourseSeq=curList[1]
      curList=nextCurList(curList,scheduleChart)
      if oldCourseSeq != curList[1]
        res+=1
      end
    end
    self.overdue_course=res
  end

  def setRecord(numOfCourses,interview)
    self.last_record_date=interview
    scheduleChart=self.getScheduleChart()
    curPhase = 1
    curCourse = 1
    while numOfCourses>1
      numOfCourses -=1
      curCourse+=1
      if curCourse>scheduleChart[curPhase-1][0]
        curCourse=1
        curPhase+=1
        if curPhase>scheduleChart.size()
          break
        end
      end
    end
    self.record_course_seq=curCourse
    self.record_phase_seq=curPhase
    self.last_record_date=interview
    self.save
  end

  def nextCurList(curList,scheduleChart)
    curPhase = curList[0]-1
    curCourse = curList[1]
    curDay = curList[2]
    curIfRest = curList[3]
    curRestDay = curList[4]
    if !curIfRest #unrest
      curDay+=1
      if curDay>scheduleChart[curPhase][1]
        curDay-=1
        curCourse+=1
        if curCourse > scheduleChart[curPhase][0]
          curCourse-=1
          if scheduleChart[curPhase][2]>0
            curIfRest=true
            curRestDay=1
          else
            curPhase+=1
            if curPhase>=scheduleChart.size()
              return [scheduleChart.size(),scheduleChart[scheduleChart.size()-1][0],
                              scheduleChart[scheduleChart.size()-1][1],false,0]
            else
              curCourse=1
              curDay=1
            end

          end

        else
          curDay=1
          curIfRest=false
          curRestDay=0
        end
      end
    else #rest
      curRestDay+=1
      if curRestDay>scheduleChart[curPhase][2]
        curRestDay=0
        curIfRest=false
        curDay=1
        curCourse=1
        curPhase+=1
        if curPhase>=scheduleChart.size()
          return [scheduleChart.size(),scheduleChart[scheduleChart.size()-1][0],
                  scheduleChart[scheduleChart.size()-1][1],false,0]
        end
      end
    end
    [curPhase+1,curCourse,curDay,curIfRest,curRestDay]
  end

  def days_till_now(date)
    date=date.strftime("%Y-%m-%d")
    d1 = Date.parse(date)
    d2 = Date.parse(Time.now.strftime("%Y-%m-%d"))
    (d2 - d1).to_i
  end

  def getScheduleChart
    self.research_group.getCourseScheduleChart
  end

end
