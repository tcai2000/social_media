import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_media/constants/index.dart';

class PostApi {
  Future<Response> createPostApi(List<File> imageList) async {
    List<MultipartFile> fileList = [];
    for (File data in imageList) {
      MultipartFile imageData = MultipartFile.fromFileSync(
        data.path,
      );
      fileList.add(imageData);
    }

    final formData = FormData.fromMap({
      "caption": "This is post test flutter 1 upload",
      "photos": fileList,
    });
    final dio = Dio();
    var addPostUri = Uri.https(dotenv.env["URL_MAIN"]!, ApiPath.addPost);
    Response res = await dio.postUri(
      addPostUri,
      data: formData,
      options: Options(
        headers: {
          "Authorization":
              "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyREIiOnsiX2lkIjoiNjQzMGZjYjNhNzFjNGI2YThiMWEwZWIwIiwidXNlcl9pZCI6IjY0MzBmY2IzYTcxYzRiNmE4YjFhMGVhZiIsInVzZXJfbmFtZSI6InRjYWkyMTAwIiwicGFzc3dvcmQiOiIkMmIkMTAkQnlVZUpSc3l6dE5hV1VxczUvaEhoLkU5bGpVNW1TcEdrbVZGMm8wMHhSaE51Sk12aVZzaWUiLCJhdmF0YXJfdXJsIjoiIiwidG9rZW4iOiJleUpoYkdjaU9pSklVekkxTmlJc0luUjVjQ0k2SWtwWFZDSjkuZXlKMWMyVnlSRUlpT25zaVgybGtJam9pTmpRek1HWmpZak5oTnpGak5HSTJZVGhpTVdFd1pXSXdJaXdpZFhObGNsOXBaQ0k2SWpZME16Qm1ZMkl6WVRjeFl6UmlObUU0WWpGaE1HVmhaaUlzSW5WelpYSmZibUZ0WlNJNkluUmpZV2t5TVRBd0lpd2ljR0Z6YzNkdmNtUWlPaUlrTW1Ja01UQWtRbmxWWlVwU2MzbDZkRTVoVjFWeGN6VXZhRWhvTGtVNWJHcFZOVzFUY0VkcmJWWkdNbTh3TUhoU2FFNTFTazEyYVZaemFXVWlMQ0poZG1GMFlYSmZkWEpzSWpvaUlpd2lkRzlyWlc0aU9pSmxlVXBvWWtkamFVOXBTa2xWZWtreFRtbEpjMGx1VWpWalEwazJTV3R3V0ZaRFNqa3VaWGxLTVdNeVZubFNSVWxwVDI1emFWZ3liR3RKYW05cFRtcFJlazFIV21wWmFrNW9UbnBHYWs1SFNUSlpWR2hwVFZkRmQxcFhTWGRKYVhkcFpGaE9iR05zT1hCYVEwazJTV3BaTUUxNlFtMVpNa2w2V1ZSamVGbDZVbWxPYlVVMFdXcEdhRTFIVm1oYWFVbHpTVzVXZWxwWVNtWmliVVowV2xOSk5rbHVVbXBaVjJ0NVRWUkJkMGxwZDJsalIwWjZZek5rZG1OdFVXbFBhVWxyVFcxSmEwMVVRV3RSYm14V1dsVndVMk16YkRaa1JUVm9WakZXZUdONlZYWmhSV2h2VEd0Vk5XSkhjRlpPVnpGVVkwVmtjbUpXV2tkTmJUaDNUVWhvVTJGRk5URlRhekV5WVZaYWVtRlhWV2xNUTBwb1pHMUdNRmxZU21aa1dFcHpTV3B2YVVscGQybGtSemx5V2xjMGFVOXBTbXhsVlhCdldXdGthbUZWT1hCVGEyeFdaV3RyZUZSdGJFcGpNR3gxVldwV2FsRXdhekpUVjNSM1YwWmFSRk5xYTNWYVdHeExUVmROZVZadWJGTlNWV3h3VkRJMWVtRldaM2xpUjNSS1lXMDVjRlJ0Y0ZKbGF6RklWMjF3V21Gck5XOVVibkJIWVdzMVNGTlVTbHBXUjJod1ZGWmtSbVF4Y0ZoVFdHUktZVmhrY0ZwR2FFOWlSMDV6VDFoQ1lWRXdhekpUVjNCYVRVVXhObEZ0TVZwTmEydzJWMVpTYW1WR2JEWlZiV3hQWWxWVk1GZFhjRWRoUlRGSVZtMW9ZV0ZWYkhwVFZ6VlhaV3h3V1ZOdFdtbGlWVm93VjJ4T1NrNXJiSFZWYlhCYVZqSjBOVlJXVWtKa01HeHdaREpzYWxJd1dqWlplazVyWkcxT2RGVlhiRkJoVld4eVZGY3hTbUV3TVZWUlYzUlNZbTE0VjFkc1ZuZFZNazE2WWtSYWExSlVWbTlXYWtaWFpVZE9ObFpZV21oU1YyaDJWRWQwVms1WFNraGpSbHBQVm5wR1ZWa3dWbXRqYlVwWFYydGtUbUpVYUROVVZXaHZWVEpHUms1VVJsUmhla1Y1V1ZaYVlXVnRSbGhXVjJ4TlVUQndiMXBITVVkTlJteFpVMjFhYTFkRmNIcFRWM0IyWVZWc2NHUXliR3RTZW14NVYyeGpNR0ZWT1hCVGJYaHNWbGhDZGxkWGRHdGhiVVpXVDFoQ1ZHRXllRmRhVjNSeVpVWlNkR0pGY0dwTlIzZ3hWbGR3VjJGc1JYZGhla3BVVmpOU00xWXdXbUZTUms1eFlUTldZVmRIZUV4VVZtUk9aVlphZFdKR1RsTldWM2gzVmtSSk1XVnRSbGRhTTJ4cFVqTlNTMWxYTURWalJsSjBZMFpLYkdGNlJrbFdNakYzVjIxR2NrNVhPVlZpYmtKSVdWZHpNVk5HVGxWVGJIQlhVakpvZDFaR1dtdFNiVkY0WTBab1ZGZEhVa3RaVm1oclkwWndSMkZGT1dsU01EVjZWREZvUTFsV1JYZGhla3BVVmpOQ1lWUlZWWGhPYkVaMFRWWndUbUV5ZHpKV01WcFRZVzFXUjJKRVdsWmlWM2hRV1d4V1ZrMUdaRmhqUldSb1VsUkdTVlp0TVc5WlYwWldZa2h3VkZaNlZsaGFWM2gzVjFaT2RGZHRiR2xXVm05M1ZqSjRUMU5yTlhKaVNGWldZbGhDWVZacVNqQk9WbEpYVld0S2EwMUhlSGRhUkVwellXeEpkMWRxV2xwbGF6VnlXa2N4VDJSR1ZsaGlSa0pvVmxkNGVWWkdZM2hUYlVWM1RWWldVbFl6VWxOWmJURTBWakZrYzFadVpGWk5hekUyV1d0U1lXRXhTbFZXYlRsWFlXdGFXRnBWWkU5T2JGcFpWMjFvVTFZeWFESldSV1F3Vm1zMVdGTnJhR3BTYkhCUVZtNXdSMVpXYTNkV2JYUnFZbFZ3V0ZZeWRHdFViVXBWWVVST1ZWWlhhSFpXVkVwSFVtczFWVkpzVW1obGExWTFWMVphWVZsWFZuUlNiR2hYVmpKNFRsVlVRbmRpTVhCSVRWVmtUbEp0ZUZwVk1qRmhZVEZrUm1OSWNGUldNMEl5V1ZaV2MyTkhVWGxpUjNSVFpXMTROVll5ZUdwTlIwWldUMWhDVkdKWWFITldiR2hEWkd4a1dHUkhkR2hpVlZwWFZERm9RMVpIUlhsbFJtUmhWak5TZVZwVldsTmtSMHBHWTBkd1RsSXpaM2hXYkdSM1ZqSkdjMUpZWkdobGEzQlZWbXBPVTAweFdYZFhiVVpUVW1zMWVGbFVUbGRaVm1SSVpVVjRWVlp0VWs5YVZscGhaRmRLUjFSc1RsZFdNMmd6Vm10U1NrMVhWblJTYkdSaFRUSjRjRlZxVGxOVE1XeFlUVVJXYWxKc1NqQlpNRnBMWWtkR05sSnJiRmROYWtZelZqSXhSMk5yTlZoUFZsWnBZbXRLU1ZkV1pIcE5WazVIVkd4V1ZHSklRbGhWYWtwdlpERmFSMWR0ZEZOaVZrWTBXVEJhYjFaR1pFaFZhM1JhVm0xb2Nsa3dXbmRTTWtaR1QxZHNVMDFFVmpaV1JFWnZVVEZzVjFKWVpHaGxhM0JWVm1wT1ExbFdVbFpXV0doUFlrVmFNRlJXV25kVWJVVjVaSHBLVjAxV2NGUlpWekZYVWpKS1JWZHNXbWxXTTJoUlYxZDRWMVpyTVVkYVJtaHFVbGRTYjFWc1VrZFRWbHAwVFZjNVdsWXdXbGRaYTJoM1ZrWmFObFpzYUdGV00yZ3pWakZhVDJSR1pIUmlSMnhYVm0wNU0xWnFTalJVTVU1eVRsaEthVk5HV2xkWmJHaERXVlphY1ZOcVFrOVdiRXBZVmxkMFMyRXdNVWhsU0dSaFVrVndlbGxYZUVwa01XUnhWMnh3YkdGNlZubFhhMk40VkRKU1IxWnNhR2xTYTBwdlZteGtOR1ZXV2tkWk0yaFVZbFZXTTFSV1dsZFZiRmw2Vld4T1dtSlVSVEJXYWtacll6RmFkVnBHV2s1aGVrVXlWMWQwVTFsWFJYaFRiRlpYWWxSc1dGbFhkR0ZYUm5CV1drVTVUMkpHY0ZwV01qRnZWVEZaZVdGRVNsZFNWMUYzVm0xek1WZEdUbkpoUjNCVFlraENVVlp0TlhkU01WcFhZVE5rVjJKWVVuRlpiRlozVjBaWmVXUkhkRlZpVlhCV1dWVlNUMVpXV2xoaFNGcFhWa1Z3U0ZWdGN6RldWa3B6Vlcxb2JHRXhXVEZXTVZwaFdWWnNXRlp1VWxOaVIyaFlWbXBLTkZSc1ZsVlJibVJwVFZoQ1NWUldWbXRVYkVwMFpVWndWazFxUm1oWlZFWnJVbTFPU1dOR1VsZE5NRWw1VjFaYVYyTXlUa2hWV0d4cFVqTlNWRnBYTVRST1ZsbDVaVWR3VGxJd1dsZFVNV2hEVmtkS1dXRklUbGRpUjJoRVdrZDRhMWRIVWtoa1IyaHBWbFp3V0ZaRVJtOVJNVnBJVWxoc2JGSnRVbWhXYWs1VFpWWndWbGRzVG10U01IQkhXVEJrZDFSc1NYcGFNMmhYWWtkU00xWnFTa2RqTVVwWldrZG9iR0V6UWxaV2JYQlBWVEF3ZUZkWVpGaGlWVnBVVlcxek1XVkdiRlZVYkdSYVZtMVNTVnBWVmpSV1ZscDBWV3M1WVZac2NHaGFSbVJMVWpGU2MxUnNaRmROTW1kNlZtMTBVMU5yTVZoV2JsSlRZa2RTYUZSVVNqUmpSbFp4Vkd4T1ZFMVhlRmxVVlZKWFlXeEtjMU5xUWxwTlJuQk1XV3RrUjA1c1NuSmlSbVJPWVd0WmVsWnFTWGhTTWs1eVRsWm9VRlpzV25CWmJYUkxVMVprVjFwSWNFNVdhelZJVmtkNFYxWkhTa2xSYkdoV1lXdHdkbHBFUm1GU01XUjBaRVpPYVZacldUQlhWRUpoWWpGYVIxcEZhRlpoTTFKaFZtMHhiMk5zYTNkWGJtUlRUV3RhUjFReFpITlZNREZGVm1wYVYxSkZXblpWVkVaelZqRktXVnBIYUd4aE0wSldWbTF3VDFFeGJGZFZiRnBYVjBkb1VGbHJWbUZOUmxKWFYyNWtWV0pWVmpWYVNIQkxWakF4VjJOR1VscFdla1pZVldwS1MxSldaSE5YYld4WFRUSm9VbFl4WkRSV01WcHlUVlZrWVZKdGFIRlZiR1JUWWpGV2MxVnJaRlJXYkhBd1ZGWmpOVmRzV1hkWGJHUmFZVEpvTTFacldtRk9iRnB6WVVkR1YwMHlaM3BXYWtaaFZESlNSMXBJVW1sU01uaFlWbTB3TlUweFduRlRhbEpWVFZVMWVWUnNhRXRoVms1SFYyeGtXbUpIYUVSWFZscGhZMVpPY1ZGck9WZGlSWEJaVm14a01GTXlSWGROVldoc1UwZFNhRlZyVm5kbGJHeFlaVVZ3YTAxWFVuaFdNbmgzWWtkR05sWnViRmhoTWs0MFZrUktVMUl4V25OaFIyeFRZVEJ3ZGxadGVHdE9SMVpYVjJ0a1drMHlhRlZaYkZaWFRURlNWMWRzWkZaaVJtdzJWbGQ0VDFkdFNsVlNWRUpYWVd0YWNsbDZSbUZrVm5CSFYyczFhR1ZyVlhsV01XUXdWVEZzV0ZKWWFGUmlSbHBZV1d4U2MxZEdiRmhrUjBaWVVtNUNWMWRyVlRWVU1rcEhZMFp3VjAxcVJuWldWRVphWlZkR1JWTnNaRk5XTVVZelZtMHhlazFXWkVkVWJrcG9Vak5DVkZscmFFTlZWbHAwVGxoa1UwMVdjRmhaVkU1clZqSktXVlZ1UmxwaVJsb3pWakJhV21WWFVraGtSbFpwVmxoQ1YxZFdWbE5VTVZwWFYyeG9hRk5HY0ZoV2ExWjNVMFpXZEdONlJsZFdhM0I2VmxjeGIySkhSWGhYVkVaWFRWWndhRmRXV25OWFJscDFWV3hPYVZJeWFGbFdiWEJMVGtaU2MxWnNWbEppYlZKd1ZGWm9RMU5XVWxkV2JYUlZZa1Z3TUZwVlduZFdhekZ4VW0xb1dsWkZXbkpWYlRGUFUxZE9SMVZzWkU1TlJXdzFWakZhWVZZeVRYbFVhMmhXVjBkNGNGVnFUbE5XUm5CWVRWUlNUMVpzYkRWYVZXUjNWR3hKZDFkc1pGVk5WMmhFVm10YVdtVlhWa1pPVmxwWFVsVnZlbGRVUm1GamJWWldUVlprWVZJeWFGUlVWbFozVTJ4YWRFMUlhRTVTYlZKWFZGWm9TMWRHWkVoVmJGWlhZV3MxUkZSWGVITldNVnBaWVVkd1YyRXhjR0ZYVjNSV1RWZEtSMWRyV2xSWFNFSllWV3BPVTFReGNFVlRiRXByVFVSc1YxZHJXbUZYUmtsNFUyeEdWMkpZVW5GVWJGVXhZekZXYzJKSGNGUlNia0o2VjFab2QyTXhXbGRWYmtwb1VqTlNWbGxyV25kVFJtdDNXa2M1VjFKc2JEVmFSRTUzVjJ4YWRGVnNVbGROVm5CSVdrVmtVMUl5VGtkaFJrNW9UVEJKTWxadGNFdE5SbVJ5VGxab1UyRXlhRmRaVkVaTFZsWmFjbGR1WkZSTlYzaFpXa1ZvVDFSck1WZFRiR3hhVFVaVmVGbFVSa3RXVmtweVYyeGtWMkpYYUZWV2EyUTBVekZPU0ZKclpGaGlSbHBZVm0xMGQxZEdXa2hOV0hCc1VsUldlbFpYZUZkWFIwWTJWbTVPV21KSGFGTmFWVnBoVWpGYWMxUnNUbWhsYTBrd1ZqSjBiMUV4V2tkYVJWcFBWbGhTWVZsVVJrdGxiR3h6VjI1a1ZGSXdjRWRaTUZVMVlVZFdjbGRyZEZkU2JGcDJWa1JHVDJSR1RuTmhSM2hUWlcxNGIxWlhlRlpOVmsxNFZXNVNhazB5YUZoV2JURlRWbXhhV0dONlJsWk5WV3cyVmxaU1MxWXhTWHBWYkZKWFRXNU9NMXBFUVhoWFZscHlUbFpLYkdKR2NEWldiWFJ2WkRKRmVWWnJXbEJXVm5CVVdXdGtiMVF4VWxkVmJrcE9Za2Q0VjFsVldrOWhSVEZYVjJ4YVZtSllRbFJXYTFWNFkyMU9SazlXWkU1V2JrSlpWa2N4ZW1WRk5YTldibFpVWWtaYVQxUldWbmRWUm1SelZteE9WVTFWTlVkVWJGWnJZVlpLV0dWR1FsZGhNbEoyVkZWYVYyTXhXbkZSYldoT1ZsUlZkMVpHV2xka01VNTBVbXhzWVZORlNsbFdhMVV4VkVac2NsZHVUbGhXYkZvd1dsVmtSMVV5Um5SbFNGcFlZVEZhVUZVeWN6RmpiVXBKVW14U1dGSXhTbEJYVm1SNlpVVXhSMVZzV2xaaVJYQnlWV3hTUjFKc2JGWlhiR1JWWWtWd1NGWnNVa3RXVm1SSlVXczVWV0pZVGpSVWJURkdaV3hhY2s1V1RsTldiRmt4Vm0xd1MyTXhUblJVV0dScFUwWmFXRmx0TVZOaFJsWnhVV3h3YTAxWFVucFhhMXBQV1ZkS1NHVkdjRmRXYlZKNlZsVmtSMVp0U2tWV2JGWlhWbXR3VEZkc1pEQk9SbHBYVW14V1VtRjZSbGhWYkZaV1pERmFkR1JHVGxKaGVrWlhWREZvUjFaV1pFbFJiRVphVmpOT00xUldXbE5UUjA1R1UyMTRVMVpHU1RCWFYzQkxZekZTVjFKWVpHcFNla1paVld0Vk1WbFdiRmRXVkZacVZtdGFlRmxyVlhoVmF6RkpVV3BPVjAxV2NIWldWekZIVm1zNVdWSnNUbGRTV0VKU1ZsZDBWMUpyTVZkVmJHeHFVbXR3VUZac1VsZGxSbFowWTBoS2ExWnJXbGhXUnpWclZsZEZlbFZ0YUZwaE1WcHlXVmN4VDJNeFJuTmlSa3BPVW10dmVsZFVRbXRPUjFKWVVtdGtZV1ZzV2xOWlYzUkxZMVprVjFwRk9XRmlWbG93V1d0V2QyRnJNSGhTVkVaaFVucENORlJWV25OWFYwbzJVV3hXVGxKRlduWlhhMmh6VTIxTmQySklVbFZpYlhob1ZtcENXbVF4WkhOYVJrNWhZa2Q0V2xaV1pITlZSMFpXWWtSV1ZWWldTa3RhVjNRMFZsWkdWVkZyTVZkU1ZWVjNWbTEwVTFGck1WWlBXRVpWVjBoQ1VWbFhjM2ROVmxKSVkwVktiRkpVVm5wWmFrcHpWRlpGZDJJemFGcE5SMUpVV1ZWa1UxTkdXblJrUm14T1lURnNNMVV4Wkhka2JVWldUVmhHVWxkSGVFOWFWbEpEVFRGU2NsUllaR3ROUkd4SVZsWm9hMVF4V2toUFZGcFZWMGhDTWxwWGN6VldSVFZKV2tVMVYxSXhTbTlWTVdSelRUSkdWMW96YUZCV1JYQkxXVmN3TlUweGNITlVhazVvVmpCYVdWVnRjRU5UYlVaMFQxUlNWV0pZUW5WYVJFRTFWbFpXVlZGck5WZFNhMWt5VjIxNFJtUldUalpoTTNCcFRXMTROVmxxUms5a01rNXpWbTFvV0ZKWVFuRlViR2hUVkVkS2RFOVVXbWxpVkVGNVZXeFdTazFIUmxoWGJYaFBWbGRTVmxaV1ZrNU5NbEp5VWxoa1RtSnRPVE5XUms1S1l6QnNkRlJ1YkdGV01GbDNWMnhrVTFwc2JGbFZWMnhRWVZWc05WUlZVa3BsYTNoVlVWUkNUVlpGUlRCV2ExSkNUVlU1Y1ZSWWNGQmhhekF4VkVkd1FtVkZOWE5pTW14TlVUQnZlRmt3WkZOaFIxSklWbTEwV1UxcldYZFRWM0IyWVZVeGNWRlliRTVsVkVJelZHdE5kMlF3T1VkVldHUlBWa2M1TmxSWWNIWmxhemxVVGtoa1RsWkhVbWhUVjJ3ellWWm5lRTlVU2twaGJUa3pXbXhPTTJGWFJsaFNha0pLWVcwNU5GUnRjRzVrTURsVlZWUkdUMkZyTUhsYWJFVjFWRlpDY1dNeldrMVZWbWhwWVVkU1RWWlZjRE5WYkZKS1RXMXNOVmd5Y0doVlIxazBZV3M1VmxneVJucFRXRll3WTFWb2ExTllSakZqZVVselNXMU9lVnBYUmpCYVYxSm1XVmhSYVU5cFNYbE5SRWw2VEZSQk1FeFVRVFJXUkVFeFQycE5lazlxVFRWTWFrRjRUbXh2YVV4RFNqRmpSMUpvWkVkV2ExZ3lSakJKYW05cFRXcEJlVTE1TUhkT1F6QjNUMFpSZDA1VWIzcE5lbTk2VDFNMGQwMVVaR0ZKYVhkcFdERTVNa2xxYjNkbVUzZHBZVmRHTUVscWIzaE9hbWQzVDFSUk1VNXFZelJtVVM1eWRtWk9lVlY1YXpOMU9IaFZNMGhDTVc1RldHaEZVRWhMUjNOME1YQlphM1IxUmtGaFRETm9XRzF2SWl3aVkzSmxZWFJsWkY5aGRDSTZJakl3TWpNdE1EUXRNRGhVTURVNk16TTZNemt1TURFMldpSXNJblZ3WkdGMFpXUmZZWFFpT2lJeU1ESXpMVEEwTFRBNFZEQTFPak16T2pNNUxqQXhOMW9pTENKZlgzWWlPakI5TENKcFlYUWlPakUyT0RBNU5UQTJOVFY5LmJabmVpR3JNOTIzdnZFdDNCVG53TjZmQmk0TnpMUjNJckVpSGdMY1VaQWsiLCJjcmVhdGVkX2F0IjoiMjAyMy0wNC0wOFQwNTozMzozOS4wMTZaIiwidXBkYXRlZF9hdCI6IjIwMjMtMDQtMDhUMDU6MzM6MzkuMDE3WiIsIl9fdiI6MH0sImlhdCI6MTY4MDk1MDgwNX0.HaqxuBzrwOoVfrFi3TSA8eXZ04Y91iobq83tFIaFNlc"
        },
      ),
    );
    return res;
  }

  Future<Map<String, dynamic>?> editPostApi() async {}

  Future<Map<String, dynamic>?> deletePostApi() async {}
}
